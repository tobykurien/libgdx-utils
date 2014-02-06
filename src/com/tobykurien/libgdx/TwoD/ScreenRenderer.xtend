package com.tobykurien.libgdx.TwoD

import com.badlogic.gdx.Gdx
import com.badlogic.gdx.graphics.GL10
import com.badlogic.gdx.graphics.OrthographicCamera
import com.badlogic.gdx.graphics.Texture
import com.badlogic.gdx.graphics.g2d.SpriteBatch
import com.badlogic.gdx.graphics.g2d.TextureRegion

class ScreenRenderer {
   SpriteBatch spriteBatch
   OrthographicCamera camera
   
   Texture splosion
   
   TextureRegion explosion

   def setup() {
      spriteBatch = new SpriteBatch();
      camera = new OrthographicCamera(320, 480);
      
      splosion = new Texture(Gdx.files.internal("data/explosion.png"))
      explosion = new TextureRegion(splosion, 256/4, 256/4)
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
      spriteBatch.draw(explosion, 50, 50);
      spriteBatch.end(); //<-- 
   }
}
