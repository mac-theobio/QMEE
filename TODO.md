# TODO

## Assignments

- read & respond to student assignments (how are we coordinating this?)

## Admin

- solve BMB's pushing problems
- add student GH IDs to roster
- add students, programmatically, to private repo: according to [this](https://gist.github.com/marchampson/4655798) (found via Googling "github api add collaborators"), we just need
```
curl -i -u "my_user_name:my_password" -X \
   PUT -d '' 'https://api.github.com/repos/my_gh_userid/my_repo/collaborators/my_collaborator_id'
```
We should look [here](http://stackoverflow.com/questions/15044534/how-to-use-ssh-authentication-with-github-api) to figure out the equivalent SSH-aware incantation.


## Optional/prettification

- put stuff in subdirectories
- don't make HTML/slides from all `.md` files (e.g. `TODO.md`)
- Add code in an appropriate place (possibly a header/footer file?) to [make ioslides use scroll bars](http://stackoverflow.com/questions/33287556/rmarkdown-ioslides-allowframebreaks-alternative) but not break: specifically (from that link) we need to incorporate
```
<style>
slides > slide { overflow: scroll; }
</style>
```
at an appropriate point in the slide files themselves, or in a CSS file they refer to
- Prettify CSS? https://www.stat.ubc.ca/~jenny/STAT545A/topic10_tablesCSS.html
- 
