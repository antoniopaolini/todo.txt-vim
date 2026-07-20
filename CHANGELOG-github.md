## 2026-07-20: v0.9.8-alpha
Added CHANGELOG-github.md for release info

## 2026-07-17: v0.9.7 (Almost done)
Cleanup and release

## 2026-07-15
+ New syntax cluster TodoAssignment, to highlight custom syntax region TodoWaitingFrom and TodoReplyTo

## 2026-07-10
Fix: when inserting new line with "o/O" add a space, like <CR> case.

## 2026-07-09
* Removed trailing spaces in file ftplugin\todo.vim
+ [PRELIMINARY] Added function to move tasks in a different file (useful if you want
    to organise tasks by files or to move , i.e.  "someday" tasks in a long-term todo file
    in order to keep clean the main "todo.txt").

## 2026-06-10
Incorporate Martin Samuelsson (aka lkfs) work: Allow syntax inclusion, by going match → region.
See https://gitlab.com/dbeniamine/todo.txt-vim/-/merge_requests/45


## 2026-06-03: v0.9.6
- autoload/todo.vim
    - Functions todo#MarkAsDone and todo#UnMarkAsDone in order to be compliant with todo.txt format: [CANCELLED] tag goes after all the dates.  Note that if a task is DONE and you type "\C" (Cancelled task) the function todo#UnMarkAsDone the task is restore, but if you type "\x" (toggle done) and the task is CANCELLED, the task is restored but the [CANCELLED] label remains.
- ftplugin/todo.vim
	- Modified keyword "Cancelled" -> [CANCELLED] to make it stand out better following the change above.
- after/syntax/todo.vim  - 2026-05-26 -AP-
	- Added syntax for NrrwRgn Plugin, to hide plugin header lines.
- after/syntax/todo.vim, syntax/todo.vim  - 2026-06-23 -AP-
	- Changed file format from dos to unix

## 2026-05-07: v0.9.5
- after/syntax/todo.vim
   - Removed (commented) Filter command.  Too useful to be relegate to a todo list files. Moved in my .vimrc.


## 2026-01-14: v0.9.4
Added character "▶" (Black Right-Pointing Triangle unicode U+25B6,digraph PR) to "ToDoProjectTitle", in order to make a torn, ragged ribbon title (by putting ◀ at the end of line to not have trailing spaces).

## 2025-11-17: v0.9.3
- after/syntax/todo.vim
	* Improved command Filter; no search highlight after opening buffer
	+Mapping for insert "Waiting from" and "reply to" arrow symbol
	+ added ":Filter" command (and :FV alias) to search and open results in a volatile
	  buffer
	* In my vimrc There's also a ":Foldsearch" (":FF") command that search and
	  fold lines doens't match. Maybe It should be put in the plugin
- syntax/todo.vim
	* Modified color for TodoPriorityB from #ffb000 to #ff8000
	* Modified color for TodoDueToday  from bold green to bold red (as
	  TodoPriorityA)

## 2025-10-23 
- Added non-standard keyword for "WaitingFor" and "ReplyTo".
- Moved all non-standard configuration to "after" directory
- Renamed Changelog file
- syntax/todo.vim
    * Modified TodoKey regex: A time string (HH:mm) was treated as a keyword.
    + Added revision number to the file.
    *  some cleanup to files

## 2025-10-23
### Summary of all changes made so far:
- Changes to the syntax for priorities A–C, W and Z.
- I’ve modified ftdetect so that it no longer highlights the todotxt help file as well
- Priorities up to Z added
etc.
### Latest changes:
- Added highlighting for the title (^======...)
- Reorganised CHANGELOG-PROVE.txt



## 2023-11-29 
Fix mapping for g:Todo_txt_prefix_creation_date variable.
Update version 0.8.2->0.9.0
Before was checked only the existence of the g:Todo_txt_prefix_creation_date variable. So the date would have been inserted even if the variable had been set to zero in .vimrc
In addition the mapping conflicts with the vim completion, if the selected item was inserted usin Carriage return and not the vim-ish <CTR-e> keys. In that case the completion item (for example the project or the context) would be followed by the date.

## 2023-11-29: First modifications based on the gitlab version downloaded at november 2023
- modified syntax file by coping highlight from the plugin https://github.com/dsiroky/vim-todotxt
- modified todo#PrependDate() function in order to have uniformity in both test case
- added highlight for some other priority (W, Y e Z for "Week", "waiting  from" and ZZZ_someday)
- function todo#PrioritizeAdd() worked only if no priority was present or was limited to [A-F]. Extended until Z







