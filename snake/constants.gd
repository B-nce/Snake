extends Node


const ROTATION_UP: float = 0
const ROTATION_DOWN: float = PI
const ROTATION_LEFT: float = (PI/2)*3
const ROTATION_RIGHT: float = PI/2
const SPRITE_SIZE: int = 16
const EPSILON: float = 0.001
const VOLUME_OFFSET : float = 0.5


#node groups
const GROUP_HEAD: StringName = "head"
const GROUP_BODY: StringName = "body"
const GROUP_WALL: StringName = "wall"
const GROUP_APPLE: StringName = "apple"
const GROUP_PLAYER: StringName = "player"
const GROUP_SCORE: StringName = "score"

#collision constants
const COLLISION_LAYER_PLAYER: int = 2
const COLLISION_LAYER_ITEM: int = 1
const COLLISION_MASK_PLAYER: int = 2

#save data keys
const DATA_VOLUME: StringName = "volume"
const DATA_IS_MUTED: StringName = "is_muted"
const DATA_HIGHSCORES: StringName = "high_scores"
const DATA_SELECTED_SKIN_PATH: StringName = "selected_skin_path_"
const DATA_SELECTED_SKIN_PATH_1: StringName = "selected_skin_path_1"
const DATA_SELECTED_SKIN_PATH_2: StringName = "selected_skin_path_2"
const DATA_SELECTED_SKIN_PATH_3: StringName = "selected_skin_path_3"
const DATA_SELECTED_SKIN_PATH_4: StringName = "selected_skin_path_4"
const DATA_LVL: StringName = "lvl"
const DATA_LVL_1: StringName = "lvl1"
const DATA_LVL_2: StringName = "lvl2"
const DATA_LVL_3: StringName = "lvl3"
const DATA_LVL_4: StringName = "lvl4"
const DATA_LVL_5: StringName = "lvl5"
const DATA_LVL_6: StringName = "lvl6"
const LVL_2_PREREQUISITE: int = 50
const LVL_3_PREREQUISITE: int = 60
const LVL_4_PREREQUISITE: int = 70
const LVL_5_PREREQUISITE: int = 90
const LVL_6_PREREQUISITE: int = 150
const LVL_PREREQUISITES: Dictionary = {DATA_LVL_2:50,DATA_LVL_3:60,DATA_LVL_4:70,DATA_LVL_5:90,DATA_LVL_6:150}
const ALBINO_BALL_PYTHON_PREREQUISITE: int = 40
const ALBINO_BOA_PREREQUISITE: int = 60
const ALBINO_BURMESE_PYTHON_PREREQUISITE: int = 50
const ALBINO_CORN_SNAKE_PREREQUISITE: int = 80
const ALBINO_ANACONDA_PREREQUISITE: int = 70
const ALBINO_KING_SNAKE_PREREQUISITE: int = 80
const ALBINO_RETICULATED_PYTHON_PREREQUISITE: int = 100
const YOUNG_TREE_BOA_PREREQUISITE: int = 130
const RATTLE_SNAKE_PREREQUISITE: int = 100
const SKIN_REQUIREMENTS = [40, 60, 50, 80, 70, 80, 100, 130, 100]
const SKIN_LEVELS = [DATA_LVL_1, DATA_LVL_1, DATA_LVL_2, DATA_LVL_2, DATA_LVL_3, DATA_LVL_4, DATA_LVL_4, DATA_LVL_5, DATA_LVL_6]
