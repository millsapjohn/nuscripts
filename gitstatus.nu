def completions [] {$env.gitpaths}

export def  --env gist [] {
 for x in $env.gitpaths {
  let git_string = (git -C $x fetch;git -C $x status)
  if 'clean' in $git_string {
   print $"(ansi green)clean: (ansi reset)($x)"
  } else if 'behind' in $git_string {
   print $'(ansi red)behind: (ansi reset)($x)'
  } else if 'to be committed' in $git_string {
   print $"(ansi yellow)uncommitted changes: (ansi reset)($x)"
  } else if 'untracked files present' in $git_string {
   print $"(ansi yellow)untracked files: (ansi reset)($x)"
  }
 }
}

export def --env "gist add" [path?: string] {
 if $path != null {
  if $path not-in $env.gitpaths {
   $env.gitpaths = ($env.gitpaths | append $path)
   $env.gitpaths | save -f ($nu.default-config-dir | path join "gitpaths.nuon")
  } else {
   "repository already listed"
  }
 } else {
  if $env.PWD not-in $env.gitpaths {
   $env.gitpaths = ($env.gitpaths | append $env.PWD)
   $env.gitpaths | save -f ($nu.default-config-dir | path join "gitpaths.nuon")
  } else {
   "repository already listed"
  }
 }
}

export def --env "gist remove" [path?: string@completions] {
 if $path != null {
  if $path in $env.gitpaths {
   $env.gitpaths = ($env.gitpaths | where ($it | $it != $path))
   $env.gitpaths | save -f ($nu.default-config-dir | path join "gitpaths.nuon")
  } else {
   "repository not listed"
  }
 } else {
  if $env.PWD in $env.gitpaths {
   $env.gitpaths = ($env.gitpaths | where ($it | $it != $env.PWD))
   $env.gitpaths | save -f ($nu.default-config-dir | path join "gitpaths.nuon")
  } else {
   "repository not listed"
  }
 }
}
