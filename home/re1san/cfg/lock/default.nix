{ colors, ... }:

with colors; {
  home.file.".config/betterlockscreen/betterlockscreenrc".text = ''
    display_on=0
    span_image=false
    lock_timeout=300
    fx_list=(dim blur dimblur pixel dimpixel color)
    dim_level=40
    blur_level=1
    pixel_scale=10,1000
    solid_color=${background}ff
    quiet=false
    loginbox=${background}5c
    loginshadow=00000000
    locktext="Type Rei's Password ^_^"
    font="Iosevka NF"
    ringcolor=${color8}66
    insidecolor=00000000
    separatorcolor=00000000
    ringvercolor=${color4}ff
    insidevercolor=00000000
    ringwrongcolor=${color9}ff
    insidewrongcolor=00000000
    timecolor=${color7}ff
    time_format="%H:%M"
    greetercolor=${color7}ff
    layoutcolor=${color7}ff
    keyhlcolor=${color4}ff
    bshlcolor=${color1}ff
    veriftext="Checking..."
    verifcolor=${color4}ff
    wrongtext="You Baka!"
    wrongcolor=${color9}ff
    modifcolor=${color5}ff
    bgcolor=${background}ff
  ''; 
}
