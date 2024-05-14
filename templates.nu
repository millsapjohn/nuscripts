def completions [] {$env.template_list | get name}

# create directories from templates
export def --env frtemp [new: path, template: string@completions] {
 if $template in ($env.template_list | get name) {
  cp -r ($env.template_list | where name == $template | get path).0 $new
  rm -r ($new | path join ".git")
 } else {
  "template not listed"
 }
}

export def --env "frtemp add" [template: string, path?: path] {
 if $template not-in ($env.template_list | get name) {
  if ($path != null) {
   $env.template_list = ($env.template_list | append {name:$template, path:$path})
  } else {
   $env.template_list = ($env.template_list | append {name:$template, path:$path})
  }
  $env.template_list | save -f ($nu.default-config-dir | path join "templates.nuon")
 } else {
  "template already listed"
 }
}

export def --env "frtemp remove" [template: string@completions] {
 if $template in ($env.template_list | get name) {
  $env.template_list = ($env.template_list | where ($it | $it.name != $template))
  $env.template_list | save -f ($nu.default-config-dir | path join "templates.nuon")
 } else {
  "template not listed"
 }
}

export def "frtemp list" [] {
 print $env.template_list
}
