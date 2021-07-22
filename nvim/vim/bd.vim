command! -bang -nargs=* -complete=file Remove call <SID>wipeout(<q-bang>, <f-args>) | call <SID>remove(<q-bang>, <q-args>)

function! s:wipeout(bang, ...)
    let l:command = 'Bwipeout' . a:bang
    for item in a:000
        exe l:command . ' ' . item
    endfor
endf

function! s:remove(bang, args)
    if a:bang
        let l:command = '!rm -f'
    else
        let l:command = '!rm'
    endif

    let l:command = l:command . ' ' . a:args
    exe 'silent ' . l:command
endf
