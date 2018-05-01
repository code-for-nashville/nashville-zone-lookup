# override compilation for https://github.com/gjaldon/heroku-buildpack-phoenix-static/
cd $phoenix_dir

mix nashville_zone_lookup.prepare_static_assets
