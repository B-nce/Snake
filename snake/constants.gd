extends Node

const ROTATION_UP: float = 0
const ROTATION_DOWN: float = PI
const ROTATION_LEFT: float = (PI/2)*3
const ROTATION_RIGHT: float = PI/2
const SPRITE_SIZE: int = 16
const EPSILON: float = 0.001

#collision constants
const COLLISION_HEAD: StringName = "head"
const COLLISION_BODY: StringName = "body"
const COLLISION_WALL: StringName = "wall"
const COLLISION_APPLE: StringName = "apple"

const COLLISION_LAYER_PLAYER: int = 2
const COLLISION_LAYER_ITEM: int = 1
const COLLISION_MASK_PLAYER: int = 2 
