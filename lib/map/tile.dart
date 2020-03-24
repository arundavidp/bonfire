import 'dart:ui';

import 'package:bonfire/rpg_game.dart';
import 'package:flame/position.dart';
import 'package:flame/sprite.dart';

class Tile {
  final String spriteImg;
  final bool collision;
  final double size;
  final Position initPosition;
  Rect _initRectPosition;
  Rect position;
  Sprite _sprite;

  Tile(this.spriteImg, this.initPosition,
      {this.collision = false, this.size = 32}) {
    _initRectPosition = Rect.fromLTWH(
      (initPosition != null ? initPosition.x : 0.0) * size,
      (initPosition != null ? initPosition.y : 0.0) * size,
      size,
      size,
    );
    position = _initRectPosition;
    if (spriteImg.isNotEmpty) _sprite = Sprite(spriteImg);
  }

  void render(Canvas canvas, Position camera) {
    if (_sprite != null && _sprite.loaded())
      _sprite.renderRect(canvas, position);
  }

  void update(RPGGame game) {
    position = Rect.fromLTWH(
      _initRectPosition.left + game.mapCamera.position.x,
      _initRectPosition.top + game.mapCamera.position.y,
      size,
      size,
    );
  }

  bool isVisible(RPGGame game) {
    if (game.size == null) return false;
    return position.left > (size * -1) &&
        position.left < game.size.width + size &&
        position.top > (size * -1) &&
        position.top < game.size.height + size;
  }
}
