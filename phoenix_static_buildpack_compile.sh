# override compilation for https://github.com/gjaldon/heroku-buildpack-phoenix-static/
cd $phoenix_dir

mix parcel.prepare_static_assets
