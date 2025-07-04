from ranger.api.commands import Command
import subprocess

class yank_full_path(Command):
    def execute(self):
        filepath = self.fm.thisfile.path
        subprocess.run(['xclip', '-selection', 'clipboard'], input=filepath.encode())
        self.fm.notify(f"Copied: {filepath}")

