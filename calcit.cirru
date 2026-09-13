
{}
  :about "|Machine-generated snapshot. Do not edit directly — changes will be overwritten. Use `calcit query` to inspect and `calcit edit`/`calcit tree` to modify. Run `calcit docs agents --contract` before mutations; use `--full` for first orientation or changed contract digest. Manual edits must follow format and schema conventions, then run `calcit edit format`."
  :package |app
  :entries $ {} $ :default
    {} (:description |) (:init-fn 'app.main/main!) (:mode :native)
      :reload-fn 'app.main/reload!
      :feature-policy $ {}
      :modules $ [] |memof/ |lilac/ |respo.calcit/ |respo-ui.calcit/ |phlox/
      :type-slots $ {}
  :files $ {}
    'app.comp.container $ %{} 'FileEntry
      :defs $ {}
        'comp-cloud $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn comp-cloud (options)
            graphics $ {}
              :ops $ []
                g :line-style $ {} (:width 3) (:alpha 1)
                  :color $ hslx 260 100 92
                g :move-to $ [] 0 0
                , & $ -> (range 20 250)
                  map $ fn (idx)
                    let
                        angle $ * -0.1 idx
                        r $ * 0.13 idx
                      g :line-to $ []
                        * r $ cos angle
                        * r $ sin angle
              :alpha 0.2
              :position $ &map:get (unsafe-coerce options 'Map) :position
          :examples $ []
          :schema $ :: 'Dynamic
        'comp-container $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn comp-container (store)
            ; println |Store store $ :tab store
            let
                cursor $ []
                states $ &map:get (unsafe-coerce store 'Map) :states
              container ({})
                comp-spiral $ {}
          :examples $ []
          :schema $ :: 'Dynamic
        'comp-spiral $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn comp-spiral (options)
            graphics $ {}
              :ops $ let
                  trail $ gen-spiral-trail 20 600
                []
                  g :line-style $ {} (:width 3) (:alpha 1)
                    :color $ hslx 260 100 70
                  g :move-to $ first trail
                  , & $ -> trail rest $ map
                    fn (p) (g :line-to p)
              :alpha 0.2
              :position $ &map:get (unsafe-coerce options 'Map) :position
          :examples $ []
          :schema $ :: 'Dynamic
        'gen-spiral-trail $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn gen-spiral-trail (from to)
            -> (range from to)
              map $ fn (idx)
                let
                    angle $ * 0.03 idx
                    r $ * 0.6 idx
                    angle2 $ * 6 angle
                    r2 60
                  complex/add
                    []
                      * r $ cos angle
                      * r $ sin angle
                    []
                      * r2 $ cos angle2
                      * r2 $ sin angle2
          :examples $ []
          :schema $ :: 'Dynamic
      :ns $ %{} 'NsEntry (:doc |)
        :code $ quote $ ns app.comp.container
          :require
            phlox.core :refer $ g hslx rect circle text container graphics create-list >>
            phlox.comp.button :refer $ comp-button
            phlox.comp.drag-point :refer $ comp-drag-point
            respo-ui.core :as ui
            memof.alias :refer $ memof-call
            phlox.complex :as complex
    'app.config $ %{} 'FileEntry
      :defs $ {}
        'dev? $ %{} 'CodeEntry (:doc |)
          :code $ quote $ def dev?
            = |dev $ option:unwrap-or (get-env |mode) |release
          :examples $ []
          :schema $ :: 'Dynamic
        'site $ %{} 'CodeEntry (:doc |)
          :code $ quote $ def site
            {}
              :dev-ui |http://localhost:8100/main.css
              :release-ui |http://cdn.tiye.me/favored-fonts/main.css
              :cdn-url |http://cdn.tiye.me/phlox/
              :title |Phlox
              :icon |http://cdn.tiye.me/logo/quamolit.png
              :storage-key |phlox
          :examples $ []
          :schema $ :: 'Dynamic
      :ns $ %{} 'NsEntry (:doc |)
        :code $ quote $ ns app.config
    'app.main $ %{} 'FileEntry
      :defs $ {}
        '*store $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defatom *store schema/store
          :examples $ []
          :schema $ :: 'Dynamic
        'dispatch! $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn dispatch! (op op-data)
            when
              and dev? $ not= op :states
              println |dispatch! op op-data
            let
                op-id $ nanoid
                op-time $ js/Date.now
              reset! *store $ updater @*store op op-data op-id op-time
          :examples $ []
          :schema $ :: 'Dynamic
        'main! $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn main! () (; js/console.log PIXI)
            if dev? $ load-console-formatter!
            ->
              new FontFaceObserver/default "|Josefin Sans"
              .!load
              unsafe-coerce 'JsObject
              .!then $ fn (event) (render-app!)
            add-watch *store :change $ fn (store prev) (render-app!)
            .!addEventListener (unsafe-coerce js/window 'JsObject) |resize $ fn (event) (render-app!)
            println "|App Started"
          :examples $ []
          :schema $ :: 'Dynamic
        'reload! $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn reload! ()
            if (nil? build-errors)
              do (println "|Code updated.")
                clear-phlox-caches!
                remove-watch *store :change
                add-watch *store :change $ fn (store prev) (render-app!)
                .!addEventListener (unsafe-coerce js/window 'JsObject) |resize $ fn (event) (render-app!)
                render-app!
                hud! |ok~ |Ok
              hud! |error build-errors
          :examples $ []
          :schema $ :: 'Dynamic
        'render-app! $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn render-app! (? arg)
            render! (comp-container @*store) dispatch! $ or arg $ {}
              :background-alpha 0
          :examples $ []
          :schema $ :: 'Dynamic
      :ns $ %{} 'NsEntry (:doc |)
        :code $ quote $ ns app.main
          :require (|pixi.js :as PIXI)
            phlox.core :refer $ render! clear-phlox-caches!
            app.comp.container :refer $ comp-container
            app.schema :as schema
            app.config :refer $ dev?
            |nanoid :refer $ nanoid
            app.updater :refer $ updater
            |fontfaceobserver-es :as FontFaceObserver
            |./calcit.build-errors :default build-errors
            |bottom-tip :default hud!
    'app.schema $ %{} 'FileEntry
      :defs $ {} $ 'store
        %{} 'CodeEntry (:doc |)
          :code $ quote $ def store
            {} (:tab :drafts) (:x 0) (:keyboard-on? false) (:counted 0)
              :states $ {}
              :cursor $ []
          :examples $ []
          :schema $ :: 'Dynamic
      :ns $ %{} 'NsEntry (:doc |)
        :code $ quote $ ns app.schema
    'app.updater $ %{} 'FileEntry
      :defs $ {} $ 'updater
        %{} 'CodeEntry (:doc |)
          :code $ quote $ defn updater (store op op-data op-id op-time)
            case-default op
              do (println "|unknown op" op op-data) store
              :add-x $ update store :x $ fn (x)
                if (> x 10) 0 $ + x 1
              :tab $ assoc store :tab op-data
              :toggle-keyboard $ update store :keyboard-on? not
              :counted $ update store :counted inc
              :states $ update-states store (&list:nth op-data 0) (&list:nth op-data 1)
              :hydrate-storage op-data
          :examples $ []
          :schema $ :: 'Dynamic
      :ns $ %{} 'NsEntry (:doc |)
        :code $ quote $ ns app.updater
          :require $ [] phlox.cursor :refer $ [] update-states
