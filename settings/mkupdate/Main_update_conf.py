# update docs and config file
import shutil
from rich.console import Console
from rich.theme import Theme
import sys
import traceback
import os

my_themes = Theme({"err":"red","ok":"green"})
console = Console(theme = my_themes)

NAS_folder = '/media/NAS/Martin/Linux/commands'
local_folder = '/home/martin/Dokumente/commands'

try:
    shutil.rmtree(NAS_folder)  # Zielordner löschen
    shutil.copytree(local_folder, NAS_folder)
except:
    traceback.print_exc(file=sys.stdout)
    console.print('\n[err]Fehler[/] - NAS gemountet? - sudo mount -a\n')
else:
    console.print('[[ok]ok[/]] commands Ordner')

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# Sources
emacs_cu_st = '/home/martin/.emacs.d/custom.el'
emacs_in_st = '/home/martin/.emacs.d/init.el'
vim_st = '/home/martin/.vimrc'
kitty_st = '/home/martin/.config/kitty/kitty.conf'
mkupdate_sh_st = '/usr/local/bin/mkupdate'
mkupdate_sc_st = '/home/martin/anaconda3/envs/update_conf/MyScripts/Main_update_conf.py'

source_list = [emacs_cu_st, emacs_in_st, vim_st, kitty_st, mkupdate_sh_st, mkupdate_sc_st]

# Targets
emacs_cu_en = '/media/NAS/Martin/Linux/settings/emacs/custom.el'
emacs_in_en = '/media/NAS/Martin/Linux/settings/emacs/init.el'
vim_en = '/media/NAS/Martin/Linux/settings/vim/vimrc'
kitty_en = '/media/NAS/Martin/Linux/settings/kitty/kitty.conf'
mkupdate_sh_en = '/media/NAS/Martin/Linux/settings/mkupdate/mkupdate'
mkupdate_sc_en = '/media/NAS/Martin/Linux/settings/mkupdate/Main_update_conf.py'

target_list = [emacs_cu_en, emacs_in_en, vim_en, kitty_en, mkupdate_sh_en, mkupdate_sc_en]

try:
    for source, target in zip(source_list,target_list):
        shutil.copy2(source, target)
        filename = os.path.basename(source)
        console.print('[[ok]ok[/]] {}'.format(filename))
except:
    traceback.print_exc(file=sys.stdout)
else:
    pass
#quell= '/Pfad/zur/Quelldatei/datei.txt'
#ziel = '/Pfad/zum/Zieldatei/Ordner/datei.txt'

##  Datei von der Quelle zum Ziel kopieren und dabei vorhandene Dateien überschreiben
#shutil.copy2(qulle, ziel)   

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#gesamter Ordner wird kopiert einzel dateine nicht nötig
#kitty_do_st = '/home/martin/Dokumente/commands/kitty_commands.txt'
#vim_do_st = '/home/martin/Dokumente/commands/vim_commands.txt'
#shell_do_st = '/home/martin/Dokumente/commands/commands.txt'
#emacs_do_st = '/home/martin/Dokumente/commands/emacs_commands.txt'



