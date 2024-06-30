" File:        todo.txt.vim
" Description: Todo.txt syntax settings
" Author:      David Beniamine <David@Beniamine.net>,Leandro Freitas <freitass@gmail.com>
" License:     Vim license
" Website:     http://github.com/dbeniamine/todo.txt-vim

if exists("b:current_syntax")
    finish
endif

syntax  cluster  TodoStart      contains=TodoTodo,TodoDone,TodoPriorityA,TodoPriorityB,TodoPriorityC,TodoPriorityD,TodoPriorityE,TodoPriorityF,TodoPriorityG,TodoPriorityH,TodoPriorityI,TodoPriorityJ,TodoPriorityK,TodoPriorityL,TodoPriorityM,TodoPriorityN,TodoPriorityO,TodoPriorityP,TodoPriorityQ,TodoPriorityR,TodoPriorityS,TodoPriorityT,TodoPriorityU,TodoPriorityV,TodoPriorityW,TodoPriorityX,TodoPriorityY,TodoPriorityZ,TodoProject,TodoContext
syntax  cluster  TodoDoneArgs   contains=TodoKey,TodoDate,TodoProject,TodoContext
syntax  cluster  TodoFullArgs   contains=@TodoDoneArgs,TodoDueToday,TodoOverDueDate,TodoThresholdDate

hi def TodoCol0 guibg=black
syntax  region TodoCol0  start=/^/ end=/$/ nextgroup=@TodoStart

syntax  region  TodoTodo       contained start=//   end=/$/  contains=@TodoFullArgs
syntax  region  TodoDone       contained start=/x /   end=/$/  contains=@TodoDoneArgs
syntax  region  TodoPriorityA  contained start=/(A) / end=/$/  contains=@TodoFullArgs
syntax  region  TodoPriorityB  contained start=/(B) / end=/$/  contains=@TodoFullArgs
syntax  region  TodoPriorityC  contained start=/(C) / end=/$/  contains=@TodoFullArgs
syntax  region  TodoPriorityD  contained start=/(D) / end=/$/  contains=@TodoFullArgs
syntax  region  TodoPriorityE  contained start=/(E) / end=/$/  contains=@TodoFullArgs
syntax  region  TodoPriorityF  contained start=/(F) / end=/$/  contains=@TodoFullArgs
syntax  region  TodoPriorityG  contained start=/(G) / end=/$/  contains=@TodoFullArgs
syntax  region  TodoPriorityH  contained start=/(H) / end=/$/  contains=@TodoFullArgs
syntax  region  TodoPriorityI  contained start=/(I) / end=/$/  contains=@TodoFullArgs
syntax  region  TodoPriorityJ  contained start=/(J) / end=/$/  contains=@TodoFullArgs
syntax  region  TodoPriorityK  contained start=/(K) / end=/$/  contains=@TodoFullArgs
syntax  region  TodoPriorityL  contained start=/(L) / end=/$/  contains=@TodoFullArgs
syntax  region  TodoPriorityM  contained start=/(M) / end=/$/  contains=@TodoFullArgs
syntax  region  TodoPriorityN  contained start=/(N) / end=/$/  contains=@TodoFullArgs
syntax  region  TodoPriorityO  contained start=/(O) / end=/$/  contains=@TodoFullArgs
syntax  region  TodoPriorityP  contained start=/(P) / end=/$/  contains=@TodoFullArgs
syntax  region  TodoPriorityQ  contained start=/(Q) / end=/$/  contains=@TodoFullArgs
syntax  region  TodoPriorityR  contained start=/(R) / end=/$/  contains=@TodoFullArgs
syntax  region  TodoPriorityS  contained start=/(S) / end=/$/  contains=@TodoFullArgs
syntax  region  TodoPriorityT  contained start=/(T) / end=/$/  contains=@TodoFullArgs
syntax  region  TodoPriorityU  contained start=/(U) / end=/$/  contains=@TodoFullArgs
syntax  region  TodoPriorityV  contained start=/(V) / end=/$/  contains=@TodoFullArgs
syntax  region  TodoPriorityW  contained start=/(W) / end=/$/  contains=@TodoFullArgs
syntax  region  TodoPriorityX  contained start=/(X) / end=/$/  contains=@TodoFullArgs
syntax  region  TodoPriorityY  contained start=/(Y) / end=/$/  contains=@TodoFullArgs
syntax  region  TodoPriorityZ  contained start=/(Z) / end=/$/  contains=@TodoFullArgs

syntax  match  TodoDate       '\d\{2,4\}-\d\{2\}-\d\{2\}'      contains=NONE
syntax  match  TodoKey        '\S*\S:\S\S*'                    contains=TodoDate
syntax  match  TodoProject    '\(^\|\s\)+[^[:blank:]]\+'       contains=NONE
syntax  match  TodoContext    '\(^\|\s\)@[^[:blank:]]\+'       contains=NONE

let s:todayDate=strftime('%Y\-%m\-%d')
execute 'syntax match TodoDueToday    /\v\c<due:' . s:todayDate . '>/ contains=NONE'

" Other priority colours might be defined by the user
highlight  default  link  TodoKey        Special
highlight  default  link  TodoDone       Comment
highlight  default  link  TodoPriorityA  Identifier
highlight  default  link  TodoPriorityB  statement
highlight  default  link  TodoPriorityC  type
highlight  default  link  TodoDate       PreProc
highlight  default  link  TodoProject    Special
highlight  default  link  TodoContext    Special
highlight  default  link  TodoDueToday   Todo

function! todo#GetDateRegexForPastDates(...)
    " Build a RegExp to match all dates prior to a reference date.
    "
    " Optionally accepts a (year, month, day) for the date, otherwise assumes the
    " reference date is the current date.
    "
    " In the end, the RegExp will look something like:
    "   =todo#GetDateRegexForPastDates(2017, 09, 15)
    "   \v(([01]\d{3}|200\d|201[0-6])\-\d{2}\-\d{2}|(2017\-(0[0-8])\-\d{2})|(2017\-09\-0\d)|(2017\-09\-1[0-4]))
    "
    " We split the RegExp into a few alternation groups:
    "   1. All dates prior to 2000, dates before this are not supported
    "   2. All previous decades for the reference date century
    "   3. The current decade up to the year prior to the reference year
    "   4. All months for the reference year up to the end of the previous month
    "   5. Days of the month part 1.
    "   6. Days of the month part 2.
    "
    " Will not work on reference dates past 2099, or before 2000.
    "
    " Invalid months and days are not checked, i.e. 2015-14-67 will match.
    "
    " Years must be 4 digits.
    "

    " Get the reference date
    let l:day=strftime("%d")
    let l:month=strftime("%m")
    let l:year=strftime("%Y")
    if a:0 >= 1
        let l:year=a:1
    endif
    if a:0 >= 2
        let l:month=a:2
    endif
    if a:0 >= 3
        let l:day=a:3
    endif

    " Use very magic mode, and start an alternation
    let l:overdueRex = '\v('

    " PART 1: 0000-1999
    " This sucker is static and won't change to year 3000. I'm not coding for the year 3000.
    let l:overdueRex = l:overdueRex . '([01]\d{3}'

    " PART 2. All previous decades for the reference date century
    " i.e. for 2017: "200\d", for 2035: "20[0-2]\d"
    "       for 2000: skip
    let l:decade = strpart(l:year, 2, 1)    " i.e. the 1 from 2017
    if l:decade > 0
        let l:overdueRex = l:overdueRex . '|20'
        if l:decade > 1
            let l:overdueRex = l:overdueRex . '[0-' . (l:decade - 1) . ']'
        else
            let l:overdueRex = l:overdueRex . '0'
        endif
        let l:overdueRex = l:overdueRex . '\d'
    endif

    " PART 3: This decade, to previous year
    " i.e. for 2017: "201[0-6]", for 2035: "203[0-4]", for 2000: skip
    let l:y = strpart(l:year, 3, 1) " Last digit of the year, i.e. 7 for 2017
    if l:y > 0
        if l:y > 1
            let l:overdueRex = l:overdueRex . '|20' . l:decade . '[0-' . (l:y - 1) . ']'
        else
            let l:overdueRex = l:overdueRex . '|20' . l:decade . '0'
        endif
    endif
    let l:overdueRex = l:overdueRex . ')\-\d{2}\-\d{2}|'

    " PART 4: All months to the end of the previous month
    " i.e. for a date of 2017-09-07, "2017-(0[1-8])-\d{2}"
    "       for 2017-10-01: "2017-(0[0-9])-\d{2}"
    "       for 2017-11-30: "2017-(0\d|1[0-0])-\d{2}"
    "       for 2017-12-30: "2017-(0\d|1[0-1])-\d{2}"
    "       for 2017-01-20: skip
    " This only applies if the reference date is not in January
    if l:month > 1
        let l:overdueRex = l:overdueRex . '(' . l:year . '\-(0'
        if l:month > 10
            let l:overdueRex = l:overdueRex . '\d|1'
        endif
        let l:y = strpart(printf('%02d', l:month), 1, 1) " Second digit of the month
        if l:month == 10
            " When the month is 10, y = 0, and y - 1 = -1 = bad, deal with it.
            let l:y = 10
        endif
        let l:overdueRex = l:overdueRex . '[0-' . (l:y - 1) . '])\-\d{2})|'
    endif

    " PART 5. Days of the month part 1.
    " i.e.  for 2017-09-07: skip
    "       for 2017-12-29: "2017-12-[0-1]\d"
    let l:y = strpart(printf('%02d', l:day), 0, 1) " First digit of the day
    if l:y > 0
        if l:y > 1
            let l:overdueRex = l:overdueRex . '(' . l:year . '\-' . printf('%02d', l:month) . '\-[0-' . (l:y - 1) . ']\d)|'
        else
            let l:overdueRex = l:overdueRex . '(' . l:year . '\-' . printf('%02d', l:month) . '\-0\d)|'
        endif
    endif

    " PART 6. Days of the month part 2.
    " i.e.  for 2017-09-07: "2017-09-0[0-6]"
    "       for 2017-12-29: "2017-12-2[0-8]"
    "       for 2017-09-20: skip
    let l:d = strpart(printf('%02d', l:day), 1, 1) " Last digit of the day
    if l:d > 0
        let l:y = strpart(printf('%02d', l:day), 0, 1) " First digit of the day
        let l:overdueRex = l:overdueRex . '(' . l:year . '\-' . printf('%02d', l:month) . '\-' . l:y
        if l:d > 1
            let l:overdueRex = l:overdueRex . '[0-' . (l:d - 1) . ']'
        else
            let l:overdueRex = l:overdueRex . '0'
        endif
        let l:overdueRex = l:overdueRex . ')'
    endif

    let l:overdueRex = substitute(l:overdueRex, '|$', '', 'e')
    let l:overdueRex = l:overdueRex . ')'

    return l:overdueRex
endfunction

function! todo#GetDateRegexForFutureDates(...)
    " Get the reference date
    let l:day=strftime("%d")
    let l:month=strftime("%m")
    let l:year=strftime("%Y")
    
    if a:0 >= 1
        let l:year=a:1
    endif
    if a:0 >= 2
        let l:month=a:2
    endif
    if a:0 >= 3
        let l:day=a:3
    endif

    " Use very magic mode, and start an alternation
    let l:futureRex = '\v('

    " Cover for all future years in the century
    let l:decade = strpart(l:year, 2, 1)
    let l:unit = strpart(l:year, 3, 1)

    let l:futureRex = l:futureRex . '(20[' . l:decade . '-9][' . (l:unit + 1) . '-9])\-\d{2}\-\d{2}'

    "Cover for future months in the current year
    if l:month < 9
        let l:fmonth = '(0['. (l:month + 1) . '-9]|1[0-2])'
    else
        let l:fmonth = '(' . (l:month + 1) . ')'
    endif
    let l:futureRex = l:futureRex . '|(' . l:year . '\-' . l:fmonth . '\-\d{2})'

    "Cover for future days in the current month
    if l:day < 9
        let l:fday = '(0[' . (l:day + 1) . '-9]|[123][0-9])'
    else
        if l:day < 19
            let l:fday = '(1[' . (l:day - 9) . '-9]|[23][0-9])'
        else
            if l:day < 29
                let l:fday = '(2[' . (l:day -19) . '-9]|3[01])'
            else
                let l:fday = '(' . (l:day + 1) . ')'
            endif
        endif
    endif

    let l:futureRex = l:futureRex . '|(' . l:year . '\-' . l:month . '\-' . l:fday . '))'
    
    return l:futureRex

endfunction

execute 'syntax match TodoOverDueDate /\v\c<due:' . todo#GetDateRegexForPastDates() . '>/'
highlight default link TodoOverDueDate Error

execute 'syntax match TodoThresholdDate /\v\c.*<t:' . todo#GetDateRegexForFutureDates() . '>/ contains=NONE'
highlight default link TodoThresholdDate Comment

let b:current_syntax = "todo"

" vim: tabstop=4 shiftwidth=4 softtabstop=4 expandtab foldmethod=marker
