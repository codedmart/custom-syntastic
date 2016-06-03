"============================================================================
"File:        custom-ghc-mod.vim
"Description: Syntax checking plugin for syntastic.vim
"Maintainer:  Brandon Martin <brandon at codedmart dot com>
"License:     This program is free software. It comes without any warranty,
"             to the extent permitted by applicable law. You can redistribute
"             it and/or modify it under the terms of the Do What The Fuck You
"             Want To Public License, Version 2, as published by Sam Hocevar.
"             See http://sam.zoy.org/wtfpl/COPYING for more details.
"
"============================================================================

if exists('g:loaded_syntastic_haskell_custom_ghc_mod_checker')
    finish
endif
let g:loaded_syntastic_haskell_custom_ghc_mod_checker = 1

let s:save_cpo = &cpo
set cpo&vim

function! SyntaxCheckers_haskell_custom_ghc_mod_GetLocList() dict " {{{1
    let makeprg = self.makeprgBuild({
        \ 'exe': self.getExecEscaped() . ' check' })

    let errorformat =
        \ '%-G%\s%#,' .
        \ '%f:%l:%c:%trror: %m,' .
        \ '%f:%l:%c:%tarning: %m,'.
        \ '%f:%l:%c: %trror: %m,' .
        \ '%f:%l:%c: %tarning: %m,' .
        \ '%f:%l:%c:%m,' .
        \ '%E%f:%l:%c:,' .
        \ '%Z%m'

    return SyntasticMake({
        \ 'makeprg': makeprg,
        \ 'errorformat': errorformat,
        \ 'preprocess': 'iconv',
        \ 'postprocess': ['compressWhitespace'],
        \ 'returns': [0] })
endfunction " }}}1

call g:SyntasticRegistry.CreateAndRegisterChecker({
    \ 'filetype': 'haskell',
    \ 'name': 'custom_ghc_mod',
    \ 'exec': 'ghc-mod' })

let &cpo = s:save_cpo
unlet s:save_cpo

" vim: set sw=4 sts=4 et fdm=marker:

