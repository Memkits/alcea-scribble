
{} (:package |app)
  :configs $ {} (:init-fn |app.main/main!) (:reload-fn |app.main/reload!)
    :modules $ [] |memof/ |lilac/ |respo.calcit/ |respo-ui.calcit/ |phlox/
    :version |0.4.10
  :entries $ {}
  :files $ {}
    |app.comp.container $ {}
      :ns $ quote
        ns app.comp.container $ :require
          phlox.core :refer $ g hslx rect circle text container graphics create-list >>
          phlox.comp.button :refer $ comp-button
          phlox.comp.drag-point :refer $ comp-drag-point
          respo-ui.core :as ui
          memof.alias :refer $ memof-call
      :defs $ {}
        |comp-container $ quote
          defn comp-container (store)
            ; println "\"Store" store $ :tab store
            let
                cursor $ []
                states $ :states store
                unit 77
                unit-lean $ / 80
                  w-log $ js/Math.sin
                    * &PI $ / 78 180
              container ({})
                graphics $ {}
                  :ops $ []
                    g :line-style $ {} (:width 1) (:alpha 1)
                      :color $ hslx 240 100 83
                    , &
                      -> (range 0 20)
                        mapcat $ fn (idx)
                          []
                            g :move-to $ [] 0 (* idx unit)
                            g :line-to $ [] 1600 (* idx unit)
                  :alpha 0.3
                  :position $ [] (* -0.5 js/window.innerWidth) (* -0.5 js/window.innerHeight)
                graphics $ {}
                  :ops $ []
                    g :line-style $ {} (:width 1) (:alpha 1)
                      :color $ hslx 240 100 83
                    , &
                      -> (range 0 16)
                        mapcat $ fn (idx)
                          []
                            g :move-to $ [] (* idx unit-lean) 1000
                            g :line-to $ []
                              + (* idx unit-lean)
                                * 1000 $ js/Math.tan
                                  * &PI $ / 12 180
                              , 0
                  :alpha 0.3
                  :position $ [] (* -0.5 js/window.innerWidth) (* -0.5 js/window.innerHeight)
                ; graphics $ {}
                  :ops $ []
                    g :line-style $ {} (:width 1) (:alpha 1)
                      :color $ hslx 240 100 83
                    g :move-to $ [] 0 0
                    g :line-to $ [] 0 1000
                  :alpha 0.3
                  :position $ [] -10 (* -0.5 js/window.innerHeight)
    |app.schema $ {}
      :ns $ quote (ns app.schema)
      :defs $ {}
        |store $ quote
          def store $ {} (:tab :drafts) (:x 0) (:keyboard-on? false) (:counted 0)
            :states $ {}
            :cursor $ []
    |app.updater $ {}
      :ns $ quote
        ns app.updater $ :require
          [] phlox.cursor :refer $ [] update-states
      :defs $ {}
        |updater $ quote
          defn updater (store op op-data op-id op-time)
            case-default op
              do (println "\"unknown op" op op-data) store
              :add-x $ update store :x
                fn (x)
                  if (> x 10) 0 $ + x 1
              :tab $ assoc store :tab op-data
              :toggle-keyboard $ update store :keyboard-on? not
              :counted $ update store :counted inc
              :states $ update-states store op-data
              :hydrate-storage op-data
    |app.main $ {}
      :ns $ quote
        ns app.main $ :require ("\"pixi.js" :as PIXI)
          phlox.core :refer $ render! clear-phlox-caches!
          app.comp.container :refer $ comp-container
          app.schema :as schema
          app.config :refer $ dev?
          "\"nanoid" :refer $ nanoid
          app.updater :refer $ updater
          "\"fontfaceobserver-es" :as FontFaceObserver
          "\"./calcit.build-errors" :default build-errors
          "\"bottom-tip" :default hud!
      :defs $ {}
        |render-app! $ quote
          defn render-app! (? arg)
            render! (comp-container @*store) dispatch! $ or arg
              {} $ :background-alpha 0
        |main! $ quote
          defn main! () (; js/console.log PIXI)
            if dev? $ load-console-formatter!
            -> (new FontFaceObserver/default "\"Josefin Sans") (.!load)
              .!then $ fn (event) (render-app!)
            add-watch *store :change $ fn (store prev) (render-app!)
            js/window.addEventListener "\"resize" $ fn (event) (render-app!)
            println "\"App Started"
        |*store $ quote (defatom *store schema/store)
        |dispatch! $ quote
          defn dispatch! (op op-data)
            when
              and dev? $ not= op :states
              println "\"dispatch!" op op-data
            let
                op-id $ nanoid
                op-time $ js/Date.now
              reset! *store $ updater @*store op op-data op-id op-time
        |reload! $ quote
          defn reload! () $ if (nil? build-errors)
            do (println "\"Code updated.") (clear-phlox-caches!) (remove-watch *store :change)
              add-watch *store :change $ fn (store prev) (render-app!)
              render-app!
              hud! "\"ok~" "\"Ok"
            hud! "\"error" build-errors
    |app.config $ {}
      :ns $ quote (ns app.config)
      :defs $ {}
        |dev? $ quote
          def dev? $ = "\"dev" (get-env "\"mode")
        |site $ quote
          def site $ {} (:dev-ui "\"http://localhost:8100/main.css") (:release-ui "\"http://cdn.tiye.me/favored-fonts/main.css") (:cdn-url "\"http://cdn.tiye.me/phlox/") (:title "\"Phlox") (:icon "\"http://cdn.tiye.me/logo/quamolit.png") (:storage-key "\"phlox")
