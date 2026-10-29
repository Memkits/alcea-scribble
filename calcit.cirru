
{}
  :about "|Machine-generated snapshot. Do not edit directly — changes will be overwritten. Use `calcit query` to inspect and `calcit edit`/`calcit tree` to modify. Run `calcit docs agents --contract` before mutations; use `--full` for first orientation or changed contract digest. Manual edits must follow format and schema conventions, then run `calcit edit format`."
  :package |app
  :entries $ {} $ :default
    {} (:description |) (:init-fn 'app.main/main!) (:mode :js) (:reload-fn 'app.main/reload!) (:target :browser)
      :feature-policy $ {}
      :modules $ [] |phlox/
      :type-slots $ {}
  :files $ {}
    'app.comp.container $ %{} 'FileEntry
      :defs $ {}
        'comp-cloud $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn comp-cloud (options)
            graphics $ {}
              :ops $ concat
                []
                  g :line-style $ {} (:width 3) (:alpha 1)
                    :color $ hslx 260 100 92
                  g :move-to $ [] 0 0
                -> (range 20 250)
                  map $ fn (idx)
                    let
                        angle $ * -0.1 idx
                        r $ * 0.13 idx
                      g :line-to $ []
                        * r $ cos angle
                        * r $ sin angle
              :alpha 0.2
              :position $ match (get options :position)
                (:some position) position
                (:none) nil
          :examples $ []
          :schema $ quote $ Fn
            Map Tag $ List Number
            -> phlox.schema/PhloxElement
        'comp-container $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn comp-container (store)
            ; println |Store store $ :tab store
            container ({})
              comp-spiral $ {}
          :examples $ []
          :schema $ quote $ Fn (Map Tag Dynamic) (-> phlox.schema/PhloxElement)
        'comp-spiral $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn comp-spiral (options)
            graphics $ {}
              :ops $ let
                  trail $ gen-spiral-trail 20 600
                concat
                  []
                    g :line-style $ {} (:width 3) (:alpha 1)
                      :color $ hslx 260 100 70
                    g :move-to $
                      first trail
                      , .unwrap
                  -> trail rest $ map $ fn (p) (g :line-to p)
              :alpha 0.2
              :position $ match (get options :position)
                (:some position) position
                (:none) nil
          :examples $ []
          :schema $ quote $ Fn
            Map Tag $ List Number
            -> phlox.schema/PhloxElement
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
          :schema $ quote $ Fn Number Number
            -> $ List $ List Number
      :ns $ %{} 'NsEntry (:doc |)
        :code $ quote $ ns app.comp.container
          :require
            phlox.core :refer $ g hslx rect circle text container graphics create-list >>
            phlox.comp.button :refer $ comp-button
            phlox.comp.drag-point :refer $ comp-drag-point
            phlox.complex :as complex
    'app.config $ %{} 'FileEntry
      :defs $ {}
        'dev? $ %{} 'CodeEntry (:doc |)
          :code $ quote $ def dev?
            = |dev $ .unwrap-or (get-env |mode) |release
          :examples $ []
          :schema $ quote Bool
        'site $ %{} 'CodeEntry (:doc |)
          :code $ quote $ def site
            {} (:dev-ui |http://localhost:8100/main.css) (:release-ui |http://cdn.tiye.me/favored-fonts/main.css) (:cdn-url |http://cdn.tiye.me/phlox/) (:title |Phlox) (:icon |http://cdn.tiye.me/logo/quamolit.png) (:storage-key |phlox)
          :examples $ []
          :schema $ quote $ Map Tag String
      :ns $ %{} 'NsEntry (:doc |)
        :code $ quote $ ns app.config
    'app.main $ %{} 'FileEntry
      :defs $ {}
        '*store $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defref *store schema/store
          :examples $ []
          :schema $ quote $ Ref (Map Tag Dynamic)
        'dispatch! $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn dispatch! (op)
            when dev? $ println |dispatch! op
            let
                op-id $ generate-id!
                op-time $ now-ms
              if (enum? op)
                reset! *store $ updater @*store op op-id op-time
                raise |expected-operation-enum
              , &unit
          :examples $ []
          :schema $ quote $ Fn Dynamic (-> Unit)
        'main! $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn main! () (; js/console.log PIXI)
            if dev? $ load-console-formatter!
            -> (new FontFaceObserver/default "|Josefin Sans") (ffi-load-font)
              ffi-then $ fn (_event) (render-app!)
            add-watch! *store :change $ fn (_store _prev) (render-app!)
            add-event-listener! |resize $ fn (_event) (render-app!)
            println "|App Started"
          :examples $ []
          :schema $ quote $ Fn (-> Unit) (:features :js-ffi)
        'reload! $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn reload! ()
            if (nil? build-errors)
              do (println "|Code updated.") (clear-phlox-caches!) (remove-watch! *store :change)
                add-watch! *store :change $ fn (_store _prev) (render-app!)
                add-event-listener! |resize $ fn (_event) (render-app!)
                render-app!
                hud! |ok~ |Ok
              hud! |error build-errors
            , &unit
          :examples $ []
          :schema $ quote $ Fn (-> Unit)
        'render-app! $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn render-app! ()
            render! (comp-container @*store) dispatch! $ {} $ :background-alpha 0
          :examples $ []
          :schema $ quote $ Fn (-> Unit)
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
      :defs $ {} $ 'store
        %{} 'CodeEntry (:doc |)
          :code $ quote $ def store
            {} (:tab :drafts) (:x 0) (:keyboard-on? false) (:counted 0)
              :states $ {}
              :cursor $ []
          :examples $ []
          :schema $ quote $ Map Tag Dynamic
      :ns $ %{} 'NsEntry (:doc |)
        :code $ quote $ ns app.schema
    'app.updater $ %{} 'FileEntry
      :defs $ {} $ 'updater
        %{} 'CodeEntry (:doc |)
          :code $ quote $ defn updater (store op op-id op-time)
            match op
              (:add-x _)
                assoc store :x $ let
                    x $ decode-map-as
                      .unwrap-or (get store :x) 0
                      , 'Number
                  if (> x 10) 0 $ + x 1
              (:tab data) (assoc store :tab data)
              (:toggle-keyboard _)
                update store :keyboard-on? $ fn (value)
                  not $ decode-map-as value 'Bool
              (:counted _)
                update store :counted $ fn (value)
                  inc $ decode-map-as value 'Number
              (:states cursor data)
                update-states store
                  decode-map-as cursor $ :: 'List 'Dynamic
                  , data
              (:hydrate-storage data)
                decode-map-as data $ :: 'Map 'Tag 'Dynamic
              _ $ do (println "|unknown op" op) store
          :examples $ []
          :schema $ quote $ Fn (Map Tag Dynamic) Enum String Number
            -> $ Map Tag Dynamic
      :ns $ %{} 'NsEntry (:doc |)
        :code $ quote $ ns app.updater
          :require $ phlox.cursor :refer $ update-states
