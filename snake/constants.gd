extends Node

const ROTATION_UP: float = 0
const ROTATION_DOWN: float = PI
const ROTATION_LEFT: float = (PI/2)*3
const ROTATION_RIGHT: float = PI/2
const SPRITE_SIZE: int = 16
const EPSILON: float = 0.001

#collision groups
const COLLISON_HEAD: StringName = "head"
const COLLISON_BODY: StringName = "body"
const COLLISON_APPLE: StringName = "apple"
