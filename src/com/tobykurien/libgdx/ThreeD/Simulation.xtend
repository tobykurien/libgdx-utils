package com.tobykurien.libgdx.ThreeD

import com.badlogic.gdx.Gdx
import com.badlogic.gdx.graphics.g3d.ModelInstance
import com.badlogic.gdx.graphics.g3d.loader.ObjLoader
import com.badlogic.gdx.graphics.g3d.utils.ModelBuilder
import com.badlogic.gdx.utils.Disposable
import java.util.ArrayList
import java.util.WeakHashMap

abstract class Simulation implements Disposable {
   public val things = new WeakHashMap<String, ModelInstance> 
   public val instances = new ArrayList<ModelInstance>
   protected val disposables = new ArrayList<Disposable>
   protected static ObjLoader objLoader
   protected static ModelBuilder modelBuilder
   
   new() {
      objLoader = new ObjLoader
      modelBuilder = new ModelBuilder
   }
   
   def abstract void populate()   
   def abstract void update(float delta)
   def abstract void pause()   
   def abstract void resume()   

   def loadAllModels(String path) {
      // load all models from assets      
      var fd = Gdx.files.internal(path)
      Gdx.app.debug("load", "Loading from " + path)
      fd.list(".obj").forEach [m|
         Gdx.app.debug("load", "Loading " + m)
         var model = objLoader.loadModel(m)
         var inst = new ModelInstance(model)
         instances.add(inst)
         things.put(m.nameWithoutExtension, inst)
         Gdx.app.debug("load", "Thing is " + m.nameWithoutExtension)
      ]      
   }
   
   override dispose() {
      disposables.forEach [ dispose ]
      instances.forEach [ dispose ]
      things.values.forEach [ dispose ]
   }
   
}