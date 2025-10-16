extends Node
#global variables that need to be accessed and changed in multiple places
#but we want them to be consistent across all the scenes
#they don't resent automatically on reload bc they're outside of the scene tree

var total_candy: int = 0 #this is for total candy across multiple runs
var candy_collected: int = 0 #this is for candy collected per run, resets when you die or finish
