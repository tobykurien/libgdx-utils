package com.tobykurien.libgdx.ThreeD

import com.badlogic.gdx.Gdx
import com.badlogic.gdx.graphics.Color
import com.badlogic.gdx.graphics.PerspectiveCamera
import com.badlogic.gdx.graphics.Texture
import com.badlogic.gdx.graphics.g2d.BitmapFont
import com.badlogic.gdx.graphics.g2d.SpriteBatch
import com.badlogic.gdx.graphics.g3d.Environment
import com.badlogic.gdx.graphics.g3d.ModelBatch
import com.badlogic.gdx.graphics.g3d.environment.DirectionalLight
import com.badlogic.gdx.graphics.g3d.utils.CameraInputController
import com.badlogic.gdx.math.Matrix4
import com.badlogic.gdx.math.Vector3
import java.util.ArrayList

import static com.badlogic.gdx.graphics.GL10.*

class Renderer {
   protected SpriteBatch spriteBatch
   protected Texture backgroundTexture
   protected BitmapFont font
   protected PerspectiveCamera camera
   protected Environment environment
   protected CameraInputController camController
   protected ArrayList<DirectionalLight> lights
   protected ModelBatch modelBatch
   protected val viewMatrix = new Matrix4()
   
   new() {
      environment = new Environment();
      lights = newArrayList
      spriteBatch = new SpriteBatch();
      modelBatch = new ModelBatch();

//         backgroundTexture = new Texture(Gdx.files.internal("data/planet.jpg"), Format.RGB565, true);
//         backgroundTexture.setFilter(TextureFilter.MipMap, TextureFilter.Linear);
//
//         font = new BitmapFont(Gdx.files.internal("data/font10.fnt"), Gdx.files.internal("data/font10.png"), false);

      camera = new PerspectiveCamera(67, Gdx.graphics.getWidth(), Gdx.graphics.getHeight());
      viewMatrix.setToOrtho2D(0, 0, 400, 320);
      spriteBatch.setProjectionMatrix(viewMatrix);

      setup
      
      if (lights.empty) {
         lights.add(new DirectionalLight().set(Color.WHITE, new Vector3(-1, -0.5f, 0).nor()))
      }      
      lights.forEach [ environment.add(it) ]
   }
   
   def render(Simulation simulation, float delta) {
      // We explicitly require GL10, otherwise we could've used the GLCommon
      // interface via Gdx.gl
      val gl = Gdx.gl;
      gl.glClear(GL_COLOR_BUFFER_BIT.bitwiseOr(GL_DEPTH_BUFFER_BIT))
      renderBackground();
      
      gl.glEnable(GL_DEPTH_TEST);
      gl.glEnable(GL_CULL_FACE);
      setProjectionAndCamera();
      
      modelBatch.begin(camera);
      modelBatch.render(simulation.instances);
      modelBatch.end();
      
      gl.glDisable(GL_CULL_FACE);
      gl.glDisable(GL_DEPTH_TEST);

      spriteBatch.setProjectionMatrix(viewMatrix);
      spriteBatch.begin();
      drawSprites(spriteBatch)
      spriteBatch.end();
   }
   
   def resize(int width, int height) {
      
   }
   
   def dispose() {
      lights.forEach [ dispose ]
      spriteBatch.dispose();
      modelBatch.dispose();
      backgroundTexture.dispose();
      font.dispose();
   }
   
   def void setup() {}
   def void setProjectionAndCamera() {}
   def void renderBackground() {}
   def void drawSprites(SpriteBatch spriteBatch) {}
}