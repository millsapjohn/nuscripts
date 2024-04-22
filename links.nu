export def --env wlink [
 dest: path # Destination linked file to be created
 src: path # Target link file to be referenced
 --bid (-b) # Bi-directional (hard) link
 --sym (-s) # One-directional (symbolic) link
 --dir (-d) # Directory link
]
