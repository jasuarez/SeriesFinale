# -*- coding: utf-8 -*-

###########################################################################
#    SeriesFinale
#    Copyright (C) 2009 Joaquim Rocha <jrocha@igalia.com>
# 
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.
###########################################################################

import pygtk
pygtk.require('2.0')
import gtk
import urllib
import os


def get_color(color_name):
    # Adapted from gPodder
    settings = gtk.settings_get_default()
    if not settings:
        return None
    color_style = gtk.rc_get_style_by_paths(settings,
                                            'GtkButton',
                                            'osso-logical-colors',
                                            gtk.Button)
    color = color_style.lookup_color(color_name)
    return "#%04x%04x%04x" % (color.red, color.green, color.blue)

def image_downloader(url, save_name):
    image = urllib.URLopener()
    path, format = os.path.splitext(url)
    target = save_name + format
    temp_target = target + '.tmp'
    image.retrieve(url, temp_target)
    os.rename(temp_target, target)
    return target
