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

#save data keys
const DATA_HIGHSCORES: StringName = "high_scores"
const DATA_SELECTED_SKIN_PATH: StringName = "selected_skin_path"
const DATA_LVL_1: StringName = "lvl1"
const DATA_LVL_2: StringName = "lvl2"
const DATA_LVL_3: StringName = "lvl3"
const DATA_LVL_4: StringName = "lvl4"
const DATA_LVL_5: StringName = "lvl5"
