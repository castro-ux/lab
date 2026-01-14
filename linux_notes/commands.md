# Ten Useful Linux Commands
1. Create ~/linux-notes directory (mkdir linux-notes; cd)
2. Initialize Git repo (git init)          
3. Create commands.md file
4. Execute a commit message (git add . \ git commit -m "message" 
5. Create GitHub repo, "lab" (gh repo create lab --public --source=. --remote=origin --push) 
6. Push local repo to GitHub
7. Create a branch, "add-vim-commands" (git switch -c add-vim-commands)
8. Edit commands.md and add Vim section
9. Commit and push the branch (git add commands.md \ git commit -m "add new feature section")
10.Create and merge a pull request on GitHub (gh pr create --title "title_comment" --body "body_comments" \ gh pr merge)
11. Pull changes to local master branch (git switch master)

# Useful Vim Commands
1. /    search
2. )    jump to next sentence
3. G    jump to last line of document
4. gg   jump to the first line of document
5. dw   delete word forward
6. db   delete word backwards
7. dd   delete line
8. yy   yank line

