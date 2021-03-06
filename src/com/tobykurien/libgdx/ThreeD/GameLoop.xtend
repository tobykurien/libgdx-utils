package com.tobykurien.libgdx.ThreeD

import com.badlogic.gdx.Screen

class GameLoop implements Screen {
   Renderer renderer
   Simulation simulation
   
   new(Renderer r, Simulation s) {
      renderer = r
      simulation = s
      simulation.populate
   }
   
   override dispose() {
      renderer.dispose
      simulation.dispose
   }
   
   override hide() {
      pause
   }
   
   override pause() {
      simulation.pause
   }
   
   override render(float delta) {
      simulation.update(delta)
      renderer.render(simulation, delta)
   }
   
   override resize(int width, int height) {
      renderer.resize(width, height)
   }
   
   override resume() {
      simulation.resume
   }
   
   override show() {
      resume
   }
   
}