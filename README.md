environment_configs
===================

Configs for vim, ssh, screen, etc.

### Add this to /etc/bash.bashrc to allow all users to keep a full history ###
```
HISTDIR="${HOME}/.history"
mkdir -p $HISTDIR
HISTTIMEFORMAT='%F %T '
HISTFILE="${HISTDIR}/bash-history_$(date +%Y%m%d)"
HISTFILESIZE=-1
HISTSIZE=-1
HISTCONTROL=ignoredups
HISTIGNORE=?:??
# append to history, don't overwrite it
shopt -s histappend
# attempt to save all lines of a multiple-line command in the same history entry
shopt -s cmdhist
# save multi-line commands to the history with embedded newlines
shopt -s lithist
```

### Keyboard Layout
//
// Brazilian Dvorak layout                                 2005-04-18
// "Teclado Simplificado Brasileiro" ou "Dvorak Brasileiro"
//
// Heitor Moraes    heitor.moraes@gmail.com
// Luiz Portella    lfpor@lujz.org
// Nando Florestan  nando2003@mandic.com.br
// Ari Caldeira     ari@tecladobrasileiro.com.br
//
partial alphanumeric_keys
xkb_symbols "dvorak" {

    name[Group1]="Portuguese (Brazil, Dvorak)";

// Numeric row
    key <TLDE> { [   dead_grave,      dead_tilde,           dead_acute,  dead_circumflex ] };
    key <AE01> { [            1,          exclam ] };
    key <AE02> { [            2,              at ] };
    key <AE03> { [            3,      numbersign ] };
    key <AE04> { [            4,          dollar ] };
    key <AE05> { [            5,         percent ] };
    key <AE06> { [            6,     asciicircum ] };
    key <AE07> { [            7,       ampersand ] };
    key <AE08> { [            8,        asterisk ] };
    key <AE09> { [            9,       parenleft ] };
    key <AE10> { [            0,      parenright ] };
    key <AE11> { [  bracketleft,       braceleft ] };
    key <AE12> { [ bracketright,      braceright ] };


// Upper row
    key <AD01> { [   apostrophe,        quotedbl ] };
    key <AD02> { [        comma,            less ] };
    key <AD03> { [       period,         greater ] };
    key <AD04> { [            p,               P ] };
    key <AD05> { [            y,               Y ] };
    key <AD06> { [            f,               F ] };
    key <AD07> { [            g,               G ] };
    key <AD08> { [            c,               C,             ccedilla,         Ccedilla ] };
    key <AD09> { [            r,               R ] };
    key <AD10> { [            l,               L ] };
    key <AD11> { [        slash,        question ] };
    key <AD12> { [        equal,            plus ] };
    key <BKSL> { [    backslash,             bar ] };

// Central row
    key <AC01> { [            a,               A ] };
    key <AC02> { [            o,               O ] };
    key <AC03> { [            e,               E ] };
    key <AC04> { [            u,               U ] };
    key <AC05> { [            i,               I ] };
    key <AC06> { [            d,               D ] };
    key <AC07> { [            h,               H ] };
    key <AC08> { [            t,               T ] };
    key <AC09> { [            n,               N ] };
    key <AC10> { [            s,               S ] };
    key <AC11> { [        minus,      underscore ] };

// Lower row
    key <LSGT> { [     ccedilla,        Ccedilla ] };
    key <AB01> { [    semicolon,           colon ] };
    key <AB02> { [            q,               Q ] };
    key <AB03> { [            j,               J ] };
    key <AB04> { [            k,               K ] };
    key <AB05> { [            x,               X ] };
    key <AB06> { [            b,               B ] };
    key <AB07> { [            m,               M ] };
    key <AB08> { [            w,               W ] };
    key <AB09> { [            v,               V ] };
    key <AB10> { [            z,               Z ] };

    key <SPCE> { [        space,           space ] };

// Configures the "," for the numeric keypad
//    include "kpdl(comma)"

// Configures the use of the AltGr key
    include "level3(ralt_switch)"
};
