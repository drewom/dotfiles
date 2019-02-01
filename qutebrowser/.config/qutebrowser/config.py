import subprocess
config.load_autoconfig()

# Useful tab bindings
config.bind('xc', 'config-cycle tabs.show always switching')
config.bind('xg', 'tab-give') # break tab into own window
config.bind('zd', 'download-open')
config.bind('xb', 'config-cycle statusbar.hide')
config.bind('xs', 'config-source') # re-source this config file
config.bind('zm', 'spawn --detach mpv --fs --speed=1.33 --force-window yes {url}') # send current page to mpv to play video
config.bind('zy', 'hint links spawn --detach mpv --fs --speed=1.33 --force-window yes {hint-url}') # send current page to mpv to play video

# switch open bindings as open in new tab is the more useful binding
config.bind('O', 'set-cmd-text -s :open ')
config.bind('o', 'set-cmd-text -s :open -t ')

# c.### are options set at launch
c.content.cookies.accept    = 'all'
c.content.geolocation       = 'ask'
c.content.webgl             = True
c.downloads.remove_finished = 800
c.auto_save.session         = True
c.editor.command            = ["termite", "-e", "nvim '{}'"]
c.scrolling.smooth          = True
c.content.autoplay          = False

# Sidebar tabs with larger favicon
c.tabs.favicons.scale       = 2.4
c.tabs.padding              = {"top": 8, "right": 0, "bottom": 8, "left": 0}
c.tabs.indicator.padding    = {"top": 8, "right": 0, "bottom": 8, "left": 0}
c.tabs.position             = "left"

# Default show tab bar when cycling though them
c.tabs.show                 = "switching"
c.tabs.show_switching_delay = 250
c.tabs.title.format         = "{audio}{title}"
c.tabs.width                = "30%"
c.tabs.select_on_remove     = 'prev' # previous tab is in the direction of parent

# search engine shortneners
c.url.searchengines = {
    "DEFAULT": "https://duckduckgo.com/?q={}",
    "g": "https://www.google.co.uk/search?&q={}",
    "gi": "https://www.google.co.uk/search?q={}&tbm=isch",
    "wiki": "https://en.wikipedia.org/w/index.php?search={}",
    "steam": "http://store.steampowered.com/search/?term={}",
    "aur": "https://aur.archlinux.org/packages/?O=0&K={}",
    "arch": "https://wiki.archlinux.org/index.php?title=Special%3ASearch&search={}",
    "syn": "https://www.thesaurus.com/browse/{}",
    "ant": "https://www.thesaurus.com/browse/{}",
    "imdb": "http://www.imdb.com/find?ref_=nv_sr_fn&s=all&q={}",
    "dic": "http://www.dictionary.com/browse/{}",
    "ety": "http://www.etymonline.com/index.php?allowed_in_frame=0&search={}",
    "urban": "http://www.urbandictionary.com/define.php?term={}",
    "yt": "https://www.youtube.com/results?search_query={}",
    "ddgi": "https://duckduckgo.com/?q={}&iar=images",
    "lutris": "https://lutris.net/games/?q={}",
    "deal": "https://isthereanydeal.com/search/?q={}",
    "gog": "https://www.gog.com/games?sort=popularity&search={}&page=1",
    "proton": "https://www.protondb.com/search?q={}",
    "qwant": "https://www.qwant.com/?q={}",
    "itch": "https://itch.io/search?q={}"
}

# call my folder shortcuts scripts
config.source('shortcuts.py')

