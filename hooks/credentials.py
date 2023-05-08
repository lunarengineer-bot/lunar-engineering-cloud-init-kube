"""Produce an SSH Key.

This makes an SSH key if it needs to for use in a cloud init file.

"""
import os
import subprocess
from pathlib import Path
from typing import Union


def write_key(pth: str) -> bool:
    if not os.path.exists(pth):
        # Make an SSH Key.
        print(f"[SSH Credentials]: Writing SSH Key to {pth}")
        subprocess.run(
            [
                'ssh-keygen',
                '-t', '{{ cookiecutter.ssh_cipher }}',
                '-a', '{{ cookiecutter.ssh_rounds }}',
                '-f', f'{pth}',
                '-N', '{{ cookiecutter.ssh_passphrase }}',
                '-C', '{{ cookiecutter.ssh_username }}',
            ]
        )
        raise Exception(f"""[SSH Credentials]:

        A public and private key were created at {pth}
        This key needs to be registered with the proxmox system.
        Please log in to your proxmox cluster and provide the SSH key.
        After that is done, please rerun the project hooks.
        """)
    else:
        print("[SSH Credentials]: SSH Already exists.")


class SSHClient():
    """Very simple OpenSSH Wrapper.

    Parameters
    ----------
    user: str
        The username on the remote system.
    ip: str
        The IP of the remote system.
    key_path: str or pathlib.Path
        The path to the private key.
    """

    def __init__(
        self,
        user: str,
        ip: str,
        key_path: Union[str, Path]
    ) -> None:
        self.user = user
        self.ip = ip
        self.key_path = str(key_path)

    def cmd(self,
            cmds: list[str],
            check=True,
            strict_host_key_checking=False,
            **run_kwargs) -> subprocess.CompletedProcess:
        
        """runs commands consecutively, ensuring success of each
            after calling the next command.
        Args:
            cmds (list[str]): list of commands to run.
            strict_host_key_checking (bool, optional): Defaults to True.
        """
        
        strict_host_key_checking = 'yes' if strict_host_key_checking else 'no'
        cmd = ' && '.join(cmds)
        return subprocess.run(
            [
                'ssh',
                '-i', self.key_path,
                '-o', f'StrictHostKeyChecking={strict_host_key_checking}', 
                '-o', 'UserKnownHostsFile=/dev/null',
                '-o', 'LogLevel=ERROR',
                f'{self.user}@{self.remote}',
                cmd
            ],
            check=check,
            **run_kwargs
        )
        
        
    def scp(self,
            sources: list[Union[str, bytes, os.PathLike]],
            destination: Union[str, bytes, os.PathLike],
            check=True,
            strict_host_key_checking=False,
            recursive=False,
            **run_kwargs) -> subprocess.CompletedProcess:
        
        """Copies `srouce` file to remote `destination` using the 
            native `scp` command.
            
        Args:
            source (Union[str, bytes, os.PathLike]): List of source files path.
            destination (Union[str, bytes, os.PathLike]): Destination path on remote.
        """

        strict_host_key_checking = 'yes' if strict_host_key_checking else 'no'

        return subprocess.run(
            list(filter(bool, [
                'scp',
                '-i', self.key_path,
                '-o', f'StrictHostKeyChecking={strict_host_key_checking}', 
                '-o', 'UserKnownHostsFile=/dev/null',
                '-o', 'LogLevel=ERROR',
                '-r' if recursive else '',
                *map(str, sources),
                # sources, 
                f'{self.user}@{self.remote}:{str(destination)}',
            ])),
            check=check,
            **run_kwargs
        )
        
    def validate(self):
        return self.cmd([f'echo " "'], check=False).returncode == 0


    def ssh_connect_cmd(self) -> str:
        return f'ssh -i {self.key_path} {self.user}@{self.remote}'