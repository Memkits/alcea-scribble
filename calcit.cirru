
{}
  :about "|Machine-generated snapshot. Do not edit directly — changes will be overwritten. Use `calcit query` to inspect and `calcit edit`/`calcit tree` to modify. Run `calcit docs agents --contract` before mutations; use `--full` for first orientation or changed contract digest. Manual edits must follow format and schema conventions, then run `calcit edit format`."
  :package |app
  :entries $ {} $ :default
    {} (:description |) (:init-fn 'app.main/main!) (:mode :native) (:reload-fn 'app.main/reload!)
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
              :position $ &map:get options :position
          :examples $ []
          :schema $ :: 'Fn $ {} (:return 'app.schema/PhloxNode)
            :args $ [] $ :: 'Map 'Tag (:: 'List 'Number)
        'comp-container $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn comp-container (store)
            ; println |Store store $ :tab store
            let
                cursor $ []
                states $ &map:get store :states
              container ({})
                comp-spiral $ {}
          :examples $ []
          :schema $ :: 'Fn $ {} (:return 'app.schema/PhloxNode)
            :args $ [] 'app.schema/Store
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
              :position $ &map:get options :position
          :examples $ []
          :schema $ :: 'Fn $ {} (:return 'app.schema/PhloxNode)
            :args $ [] $ :: 'Map 'Tag (:: 'List 'Number)
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
          :schema $ :: 'Fn $ {}
            :args $ [] 'Number 'Number
            :return $ :: 'List $ :: 'List 'Number
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
          :schema $ :: 'Bool
        'site $ %{} 'CodeEntry (:doc |)
          :code $ quote $ def site
            {} (:dev-ui |http://localhost:8100/main.css) (:release-ui |http://cdn.tiye.me/favored-fonts/main.css) (:cdn-url |http://cdn.tiye.me/phlox/) (:title |Phlox) (:icon |http://cdn.tiye.me/logo/quamolit.png) (:storage-key |phlox)
          :examples $ []
          :schema $ :: 'Map 'Tag 'String
      :ns $ %{} 'NsEntry (:doc |)
        :code $ quote $ ns app.config
    'app.main $ %{} 'FileEntry
      :defs $ {}
        '*store $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defatom *store schema/store
          :examples $ []
          :schema $ :: 'Ref 'app.schema/Store
        'dispatch! $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn dispatch! (op)
            when dev? $ println |dispatch! op
            let
                op-id $ generate-id!
                op-time $ now-ms
              reset! *store $ updater @*store (assert-type op 'Enum) op-id op-time
          :examples $ []
          :schema $ :: 'Fn $ {} (:return 'Unit)
            :args $ [] 'Dynamic
        'main! $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn main! () (; js/console.log PIXI)
            if dev? $ load-console-formatter!
            -> (new FontFaceObserver/default "|Josefin Sans") (ffi-load-font)
              ffi-then $ fn (_event) (render-app!)
            add-watch *store :change $ fn (_store _prev) (render-app!)
            add-event-listener! |resize $ fn (_event) (render-app!)
            println "|App Started"
          :examples $ []
          :schema $ :: 'Fn $ {} (:return 'Unit)
            :args $ []
            :features $ #{} :js-ffi
        'reload! $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn reload! ()
            if (nil? build-errors)
              do (println "|Code updated.") (clear-phlox-caches!) (remove-watch *store :change)
                add-watch *store :change $ fn (_store _prev) (render-app!)
                add-event-listener! |resize $ fn (_event) (render-app!)
                render-app!
                hud! |ok~ |Ok
              hud! |error build-errors
          :examples $ []
          :schema $ :: 'Fn $ {} (:return 'Unit)
            :args $ []
        'render-app! $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn render-app! ()
            render! (comp-container @*store) dispatch! $ {} $ :background-alpha 0
          :examples $ []
          :schema $ :: 'Fn $ {} (:return 'Unit)
            :args $ []
      :ns $ %{} 'NsEntry (:doc |)
        :code $ quote $ ns app.main
          :require (|pixi.js :as PIXI)
            phlox.core :refer $ render! clear-phlox-caches! ffi-load-font ffi-then
            app.comp.container :refer $ comp-container
            app.schema :as schema
            app.config :refer $ dev?
            app.updater :refer $ updater
            |fontfaceobserver-es :as FontFaceObserver
            |./calcit.build-errors :default build-errors
            |bottom-tip :default hud!
            js-ffi.browser :refer $ add-event-listener!
            js-ffi.shared :refer $ now-ms
    'app.schema $ %{} 'FileEntry
      :defs $ {}
        'PhloxNode $ %{} 'CodeEntry (:doc |)
          :code $ quote $ def PhloxNode &unit
          :examples $ []
          :schema $ :: 'Dynamic
        'Store $ %{} 'CodeEntry (:doc |)
          :code $ quote $ def Store &unit
          :examples $ []
          :schema $ :: 'Map 'Tag 'Dynamic
        'store $ %{} 'CodeEntry (:doc |)
          :code $ quote $ def store
            {} (:tab :drafts) (:x 0) (:keyboard-on? false) (:counted 0)
              :states $ {}
              :cursor $ []
          :examples $ []
          :schema $ :: 'app.schema/Store
      :ns $ %{} 'NsEntry (:doc |)
        :code $ quote $ ns app.schema
    'app.updater $ %{} 'FileEntry
      :defs $ {} $ 'updater
        %{} 'CodeEntry (:doc |)
          :code $ quote $ defn updater (store op op-id op-time)
            match op
              (:add-x _)
                assoc store :x $ let
                    x $ assert-type
                      option:unwrap-or (get store :x) 0
                      , 'Number
                  if (> x 10) 0 $ + x 1
              (:tab data) (assoc store :tab data)
              (:toggle-keyboard _) (update store :keyboard-on? not)
              (:counted _) (update store :counted inc)
              (:states cursor data) (update-states store cursor data)
              (:hydrate-storage data) data
              _ $ do (println "|unknown op" op) store
          :examples $ []
          :schema $ :: 'Fn $ {} (:return 'app.schema/Store)
            :args $ [] 'app.schema/Store 'Enum 'String 'Number
      :ns $ %{} 'NsEntry (:doc |)
        :code $ quote $ ns app.updater
          :require $ [] phlox.cursor :refer $ [] update-states
