package com.tobykurien.libgdx.ThreeD

import com.badlogic.gdx.Gdx
import com.badlogic.gdx.graphics.g3d.ModelInstance
import com.badlogic.gdx.graphics.g3d.loader.ObjLoader
import com.badlogic.gdx.utils.Disposable
import java.util.ArrayList
import java.util.WeakHashMap

abstract class Simulation implements Disposable {
   val things = new WeakHashMap<String, ModelInstance> 
   public val instances = new ArrayList<ModelInstance>
   val disposables = new ArrayList<Disposable>
   static ObjLoader objLoader = new ObjLoader
   
   def abstract void populate()   
   def abstract void update(float delta)

   def loadAllModels(String path) {
      // load all models from assets      
      var fd = Gdx.files.internal(path)
      fd.list(".obj").forEach [m|
         var model = objLoader.loadModel(m)
         var inst = new ModelInstance(model)
         instances.add(inst)
         things.put(m.nameWithoutExtension, inst)
      ]      
   }
   
   override dispose() {
      disposables.forEach [ dispose ]
      instances.forEach [ dispose ]
      things.values.forEach [ dispose ]
   }
   
}