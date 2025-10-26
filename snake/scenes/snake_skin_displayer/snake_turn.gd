extends TextureRect

var snake_skin: AtlasTexture = AtlasTexture.new()
var skin: Texture2D
var sprite_rect: Rect2

func _ready() ->void:
	self.texture = snake_skin
