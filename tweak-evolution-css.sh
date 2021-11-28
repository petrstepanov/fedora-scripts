#/bin/bash

GTK_CSS=${HOME}/.config/gtk-3.0/gtk.css

touch ${GTK_CSS}

cat ./HOME/.config/gtk-3.0/geary.css ${GTK_CSS} >> ${GTK_CSS}
