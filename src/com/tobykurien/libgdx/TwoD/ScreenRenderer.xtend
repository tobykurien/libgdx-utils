package com.tobykurien.libgdx.TwoD

import com.badlogic.gdx.Gdx
import com.badlogic.gdx.graphics.GL10
import com.badlogic.gdx.graphics.OrthographicCamera
import com.badlogic.gdx.graphics.Texture
import com.badlogic.gdx.graphics.g2d.Sprite
import com.badlogic.gdx.graphics.g2d.SpriteBatch
import com.badlogic.gdx.graphics.g2d.TextureRegion

/**
 * Example of rendering 2d stuff
 */
class ScreenRenderer {
   SpriteBatch spriteBatch
   OrthographicCamera camera
   
   Sprite sprite

   def setup() {
      spriteBatch = new SpriteBatch();
      camera = new OrthographicCamera(320, 480);
      
      var splosion = new Texture(Gdx.files.internal("data/explosion.png"))
      var explosion = new TextureRegion(splosion, 256/4, 256/4)
      sprite = new Sprite(explosion)
   }

   def render(float delta) {
      var gl = Gdx.gl;

      //clear the screen with Black  
      gl.glClearColor(0, 0, 0, 1);
      gl.glClear(GL10.GL_COLOR_BUFFER_BIT);

      camera.update();

      spriteBatch.setProjectionMatrix(camera.combined);
      spriteBatch.enableBlending();

      spriteBatch.begin(); //<--
      sprite.draw(spriteBatch)  
      spriteBatch.end(); //<-- 
   }

   def dispose() {
      spriteBatch.dispose
      sprite.texture.dispose
   }
}
