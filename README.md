# timelapse
Scripts and config files for time lapse creation using Motion and ffmpeg

1. `fetch.sh` - fetch the files from the server
2. `rename.sh` - copy the fetched files into date-based directories and filenames
3. delete any nearly-empty directories
4. `preview.sh` - generate preview videos of each remaining date directory
5. manually review the renamed files and put all the keepers into a single directory
6. `renumber.sh` - renumber all the kept files so ffmpeg can process them
7. `generate.sh` - generate a video from the renumbered files

