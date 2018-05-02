# Scripting Youtube-DL Brolen Down Case by Case

So I'm pretty much gonna append the results of running different ytdl commands
here. Make it easy to get the exact command i want.

So far im thinking termux-url-opener is gonna be an if-elif chain with different
youtube commands. 
if they choose something else go to the termux-urls.ipy (or .py by then)

So this is the command i have setup to download 1 url audio only
youtube-dl --no-mtime -o "/data/data/com.termux/files/home/storage/shared/music/%(title)s.%(ext)s" -f "bestaudio" $1;;

It doesn't pick up the metadata correctly at all unfortunately. however i
think theres an option that can fix that.

--add-metadata
don't know how it works but whatever.

--metadata-from-title FORMAT
is another way but there we go with the regular expressions

oh also that title is long as balls and doesn't even change so probably do some

dl=/path/to/file

case:
    //logic
esac

unset dl

or something

damn this was a huge amount of talking and no results so far!!

lets get to it.

Downloading 1 video with metadata in Videos [make sure to change music to Music]

u0_a144@localhost:~/projects/dotfiles/unix/bin (master *)$ youtube-dl --no-mtime -o "/data/data/com.termux/files/home/storage/shared/music/%(title)s.%(ext)s" -F --add-metadata https://youtu.be/Oz_-VaTHpc8
[youtube] Oz_-VaTHpc8: Downloading webpage
[youtube] Oz_-VaTHpc8: Downloading video info webpage
[youtube] Oz_-VaTHpc8: Extracting video information
[youtube] Oz_-VaTHpc8: Downloading js player vfl5ItJAe
[info] Available formats for Oz_-VaTHpc8:
format code  extension  resolution note
249          webm       audio only DASH audio   53k , opus @ 50k, 1.25MiB
250          webm       audio only DASH audio   70k , opus @ 70k, 1.65MiB
171          webm       audio only DASH audio  124k , vorbis@128k, 2.90MiB
140          m4a        audio only DASH audio  128k , m4a_dash container, mp4a.40.2@128k, 3.19MiB
251          webm       audio only DASH audio  140k , opus @160k, 3.20MiB
278          webm       192x144    144p   73k , webm container, vp9, 24fps, video only, 1.70MiB
160          mp4        192x144    144p   86k , avc1.4d400b, 24fps, video only, 1.92MiB
242          webm       320x240    240p  168k , vp9, 24fps, video only, 3.82MiB
133          mp4        320x240    240p  187k , avc1.4d400d, 24fps, video only, 3.85MiB
243          webm       480x360    360p  306k , vp9, 24fps, video only, 6.71MiB
134          mp4        480x360    360p  479k , avc1.4d4015, 24fps, video only, 9.26MiB
244          webm       640x480    480p  576k , vp9, 24fps, video only, 11.87MiB
135          mp4        640x480    480p  879k , avc1.4d401e, 24fps, video only, 17.18MiB
17           3gp        176x144    small , mp4v.20.3, mp4a.40.2@ 24k
36           3gp        320x240    small , mp4v.20.3, mp4a.40.2
18           mp4        480x360    medium , avc1.42001E, mp4a.40.2@ 96k
43           webm       640x360    medium , vp8.0, vorbis@128k (best)
u0_a144@localhost:~/projects/dotfiles/unix/bin (master *)$ youtube-dl --no-mtime -o "/data/data/com.termux/files/home/storage/shared/Videos/%(title)s.%(ext)s"  --add-metadata https://youtu.be/Oz_-VaTHpc8
[youtube] Oz_-VaTHpc8: Downloading webpage
[youtube] Oz_-VaTHpc8: Downloading video info webpage
[youtube] Oz_-VaTHpc8: Extracting video information
WARNING: Requested formats are incompatible for merge and will be merged into mkv.
[download] Destination: /data/data/com.termux/files/home/storage/shared/Videos/JAY-Z - Dirt Off Your Shoulder.f135.mp4
[download] 100% of 17.18MiB in 00:02
[download] Destination: /data/data/com.termux/files/home/storage/shared/Videos/JAY-Z - Dirt Off Your Shoulder.f251.webm
[download] 100% of 3.20MiB in 00:00
[ffmpeg] Merging formats into "/data/data/com.termux/files/home/storage/shared/Videos/JAY-Z - Dirt Off Your Shoulder.mkv"
Deleting original file /data/data/com.termux/files/home/storage/shared/Videos/JAY-Z - Dirt Off Your Shoulder.f135.mp4 (pass -k to keep)
Deleting original file /data/data/com.termux/files/home/storage/shared/Videos/JAY-Z - Dirt Off Your Shoulder.f251.webm (pass -k to keep)
[ffmpeg] Adding metadata to '/data/data/com.termux/files/home/storage/shared/Videos/JAY-Z - Dirt Off Your Shoulder.mkv'





now downloading a song with metadata

u0_a144@localhost:~/projects/dotfiles/unix/bin (master *)$ youtube-dl --no-mtime -o "/data/data/com.termux/files/home/storage/shared/Music/%(title)s.%(ext)s" --metadata-from-title "%(artist)s - %(title)s" --add-metadata -x --audio-format best --embed-thumbnail https://youtu.be/8HBTiDD9BCA
[youtube] 8HBTiDD9BCA: Downloading webpage
[youtube] 8HBTiDD9BCA: Downloading video info webpage
[youtube] 8HBTiDD9BCA: Extracting video information
[youtube] 8HBTiDD9BCA: Downloading thumbnail ...
[youtube] 8HBTiDD9BCA: Writing thumbnail to: /data/data/com.termux/files/home/storage/shared/Music/Lucifer (Explicit).jpg
[download] Destination: /data/data/com.termux/files/home/storage/shared/Music/Lucifer (Explicit).webm
[download] 100% of 3.03MiB in 00:00
[fromtitle] Could not interpret title of video as "%(artist)s - %(title)s"
[ffmpeg] Destination: /data/data/com.termux/files/home/storage/shared/Music/Lucifer (Explicit).opus
Deleting original file /data/data/com.termux/files/home/storage/shared/Music/Lucifer (Explicit).webm (pass -k to keep)
[ffmpeg] Adding metadata to '/data/data/com.termux/files/home/storage/shared/Music/Lucifer (Explicit).opus'
ERROR: Only mp3 and m4a/mp4 are supported for thumbnail embedding for now.
u0_a144@localhost:~/projects/dotfiles/unix/bin (master *)$


i got "Jay-Z (Topic)" as an artist but whatever.
still playing with it. worst come to worst we use some re magic!!


ran this command:
u0_a144@localhost:~/projects/dotfiles/unix/bin (master *)$ youtube-dl --no-mtime -o "/data/data/com.termux/files/home/storage/shared/Music/%(title)s.%(ext)s" --metadata-from-title "%(artist)s - %(title)s" --add-metadata -x --audio-format best https://youtu.be/xufJHc2EdBA >> yt-results.test


[youtube] xufJHc2EdBA: Downloading webpage
[youtube] xufJHc2EdBA: Downloading video info webpage
[youtube] xufJHc2EdBA: Extracting video information
[download] Destination: /data/data/com.termux/files/home/storage/shared/Music/Big Sean - Control f. Kendrick Lamar & Jay Electronica.webm
[K[download]   0.0% of 7.26MiB at 241.62KiB/s ETA 00:31[K[download]   0.0% of 7.26MiB at 621.04KiB/s ETA 00:12[K[download]   0.1% of 7.26MiB at  1.30MiB/s ETA 00:05[K[download]   0.2% of 7.26MiB at  1.48MiB/s ETA 00:04[K[download]   0.4% of 7.26MiB at  1.74MiB/s ETA 00:04[K[download]   0.8% of 7.26MiB at  1.79MiB/s ETA 00:04[K[download]   1.7% of 7.26MiB at  2.55MiB/s ETA 00:02[K[download]   3.4% of 7.26MiB at  3.82MiB/s ETA 00:01[K[download]   6.9% of 7.26MiB at  5.28MiB/s ETA 00:01[K[download]  13.8% of 7.26MiB at  7.32MiB/s ETA 00:00[K[download]  27.5% of 7.26MiB at  8.81MiB/s ETA 00:00[K[download]  55.0% of 7.26MiB at 10.00MiB/s ETA 00:00[K[download] 100.0% of 7.26MiB at 10.39MiB/s ETA 00:00[K[download] 100% of 7.26MiB in 00:01
[fromtitle] parsed artist: Big Sean
[fromtitle] parsed title: Control f. Kendrick Lamar & Jay Electronica
[ffmpeg] Destination: /data/data/com.termux/files/home/storage/shared/Music/Big Sean - Control f. Kendrick Lamar & Jay Electronica.ogg
Deleting original file /data/data/com.termux/files/home/storage/shared/Music/Big Sean - Control f. Kendrick Lamar & Jay Electronica.webm (pass -k to keep)
[ffmpeg] Adding metadata to '/data/data/com.termux/files/home/storage/shared/Music/Big Sean - Control f. Kendrick Lamar & Jay Electronica.ogg'







[youtube] cykGnl1KvcM: Downloading webpage
[youtube] cykGnl1KvcM: Downloading video info webpage
[youtube] cykGnl1KvcM: Extracting video information
[youtube] cykGnl1KvcM: Downloading webpage
[youtube] cykGnl1KvcM: Downloading video info webpage
[youtube] cykGnl1KvcM: Extracting video information
[info] Available formats for cykGnl1KvcM:
format code  extension  resolution note
249          webm       audio only DASH audio   58k , opus @ 50k, 1.39MiB
250          webm       audio only DASH audio   81k , opus @ 70k, 1.89MiB
171          webm       audio only DASH audio  121k , vorbis@128k, 2.91MiB
140          m4a        audio only DASH audio  128k , m4a_dash container, mp4a.40.2@128k, 3.31MiB
251          webm       audio only DASH audio  154k , opus @160k, 3.58MiB
160          mp4        192x144    144p   11k , avc1.4d400b, 25fps, video only, 237.41KiB
133          mp4        320x240    240p   19k , avc1.4d400d, 25fps, video only, 364.42KiB
278          webm       192x144    144p   31k , webm container, vp9, 13fps, video only, 533.18KiB
134          mp4        480x360    360p   44k , avc1.4d4015, 25fps, video only, 781.52KiB
242          webm       320x240    240p   58k , vp9, 25fps, video only, 990.29KiB
135          mp4        640x480    480p   82k , avc1.4d401e, 25fps, video only, 1.41MiB
243          webm       480x360    360p   94k , vp9, 25fps, video only, 1.55MiB
244          webm       640x480    480p  148k , vp9, 25fps, video only, 2.41MiB
17           3gp        176x144    small , mp4v.20.3, mp4a.40.2@ 24k
36           3gp        320x240    small , mp4v.20.3, mp4a.40.2
18           mp4        480x360    medium , avc1.42001E, mp4a.40.2@ 96k
43           webm       640x360    medium , vp8.0, vorbis@128k (best)




[youtube] cykGnl1KvcM: Downloading webpage
[youtube] cykGnl1KvcM: Downloading video info webpage
[youtube] cykGnl1KvcM: Extracting video information
[download] Destination: /data/data/com.termux/files/home/storage/shared/Music/Lil Wayne - I Feel Like Dying.f244.webm
[K[download]   0.0% of 2.41MiB at 93.72KiB/s ETA 00:26[K[download]   0.1% of 2.41MiB at 258.15KiB/s ETA 00:09[K[download]   0.3% of 2.41MiB at 564.28KiB/s ETA 00:04[K[download]   0.6% of 2.41MiB at  1.05MiB/s ETA 00:02[K[download]   1.3% of 2.41MiB at  2.00MiB/s ETA 00:01[K[download]   2.6% of 2.41MiB at  1.75MiB/s ETA 00:01[K[download]   5.1% of 2.41MiB at  2.64MiB/s ETA 00:00[K[download]  10.3% of 2.41MiB at  3.60MiB/s ETA 00:00[K[download]  20.7% of 2.41MiB at  5.38MiB/s ETA 00:00[K[download]  41.4% of 2.41MiB at  8.60MiB/s ETA 00:00[K[download]  82.9% of 2.41MiB at 11.94MiB/s ETA 00:00[K[download] 100.0% of 2.41MiB at 13.11MiB/s ETA 00:00[K[download] 100% of 2.41MiB in 00:00
[download] Destination: /data/data/com.termux/files/home/storage/shared/Music/Lil Wayne - I Feel Like Dying.f251.webm
[K[download]   0.0% of 3.58MiB at 177.69KiB/s ETA 00:21[K[download]   0.1% of 3.58MiB at 398.47KiB/s ETA 00:09[K[download]   0.2% of 3.58MiB at 779.05KiB/s ETA 00:04[K[download]   0.4% of 3.58MiB at 1013.30KiB/s ETA 00:03[K[download]   0.8% of 3.58MiB at  1.88MiB/s ETA 00:01[K[download]   1.7% of 3.58MiB at  2.66MiB/s ETA 00:01[K[download]   3.5% of 3.58MiB at  3.15MiB/s ETA 00:01[K[download]   7.0% of 3.58MiB at  4.63MiB/s ETA 00:00[K[download]  13.9% of 3.58MiB at  6.79MiB/s ETA 00:00[K[download]  27.9% of 3.58MiB at  9.01MiB/s ETA 00:00[K[download]  55.8% of 3.58MiB at 12.01MiB/s ETA 00:00[K[download] 100.0% of 3.58MiB at 13.77MiB/s ETA 00:00[K[download] 100% of 3.58MiB in 00:00
[ffmpeg] Merging formats into "/data/data/com.termux/files/home/storage/shared/Music/Lil Wayne - I Feel Like Dying.webm"
Deleting original file /data/data/com.termux/files/home/storage/shared/Music/Lil Wayne - I Feel Like Dying.f244.webm (pass -k to keep)
Deleting original file /data/data/com.termux/files/home/storage/shared/Music/Lil Wayne - I Feel Like Dying.f251.webm (pass -k to keep)
[fromtitle] parsed artist: Lil Wayne
[fromtitle] parsed title: I Feel Like Dying
[ffmpeg] Adding metadata to '/data/data/com.termux/files/home/storage/shared/Music/Lil Wayne - I Feel Like Dying.webm'







[youtube] skN5U4dlmrE: Downloading webpage
[youtube] skN5U4dlmrE: Downloading video info webpage
[youtube] skN5U4dlmrE: Extracting video information
[youtube] skN5U4dlmrE: Downloading js player vfluI_BcD
[download] Destination: /data/data/com.termux/files/home/storage/shared/Music/Lil Wayne - Hollyweezy (Official Music Video).f137.mp4
[K[download]   0.0% of 46.79MiB at 303.61KiB/s ETA 02:46[K[download]   0.0% of 46.79MiB at 543.12KiB/s ETA 01:30[K[download]   0.0% of 46.79MiB at 803.90KiB/s ETA 01:08[K[download]   0.0% of 46.79MiB at 787.12KiB/s ETA 01:01[K[download]   0.1% of 46.79MiB at  1.42MiB/s ETA 00:32[K[download]   0.1% of 46.79MiB at  2.24MiB/s ETA 00:20[K[download]   0.3% of 46.79MiB at  3.14MiB/s ETA 00:14[K[download]   0.5% of 46.79MiB at  4.24MiB/s ETA 00:10[K[download]   1.1% of 46.79MiB at  5.91MiB/s ETA 00:07[K[download]   2.1% of 46.79MiB at  8.23MiB/s ETA 00:05[K[download]   4.3% of 46.79MiB at  9.24MiB/s ETA 00:04[K[download]   8.5% of 46.79MiB at 10.79MiB/s ETA 00:03[K[download]  17.1% of 46.79MiB at 12.67MiB/s ETA 00:03[K[download]  21.1% of 46.79MiB at 11.99MiB/s ETA 00:03[K[download]  21.1% of 46.79MiB at Unknown speed ETA Unknown ETA[K[download]  21.1% of 46.79MiB at Unknown speed ETA Unknown ETA[K[download]  21.1% of 46.79MiB at  4.79MiB/s ETA 00:07[K[download]  21.2% of 46.79MiB at  5.83MiB/s ETA 00:06[K[download]  21.2% of 46.79MiB at  1.83MiB/s ETA 00:20[K[download]  21.3% of 46.79MiB at  1.94MiB/s ETA 00:19[K[download]  21.4% of 46.79MiB at  2.36MiB/s ETA 00:15[K[download]  21.7% of 46.79MiB at  3.68MiB/s ETA 00:09[K[download]  22.2% of 46.79MiB at  4.06MiB/s ETA 00:08[K[download]  23.3% of 46.79MiB at  6.08MiB/s ETA 00:05[K[download]  25.4% of 46.79MiB at  7.82MiB/s ETA 00:04[K[download]  29.7% of 46.79MiB at  9.73MiB/s ETA 00:03[K[download]  38.2% of 46.79MiB at  9.64MiB/s ETA 00:02[K[download]  41.5% of 46.79MiB at  9.60MiB/s ETA 00:02[K[download]  41.5% of 46.79MiB at 890.70KiB/s ETA 00:37[K[download]  41.5% of 46.79MiB at 904.07KiB/s ETA 00:32[K[download]  41.5% of 46.79MiB at  1.27MiB/s ETA 00:22[K[download]  41.5% of 46.79MiB at  1.26MiB/s ETA 00:21[K[download]  41.5% of 46.79MiB at  1.75MiB/s ETA 00:15[K[download]  41.6% of 46.79MiB at  1.95MiB/s ETA 00:14[K[download]  41.7% of 46.79MiB at  3.09MiB/s ETA 00:08[K[download]  42.0% of 46.79MiB at  4.25MiB/s ETA 00:06[K[download]  42.5% of 46.79MiB at  6.38MiB/s ETA 00:04[K[download]  43.6% of 46.79MiB at  8.98MiB/s ETA 00:02[K[download]  45.8% of 46.79MiB at 10.74MiB/s ETA 00:02[K[download]  50.0% of 46.79MiB at 11.79MiB/s ETA 00:01[K[download]  58.6% of 46.79MiB at 11.08MiB/s ETA 00:01[K[download]  62.3% of 46.79MiB at 10.68MiB/s ETA 00:01[K[download]  62.3% of 46.79MiB at Unknown speed ETA Unknown ETA[K[download]  62.3% of 46.79MiB at  2.24MiB/s ETA 00:08[K[download]  62.3% of 46.79MiB at  3.19MiB/s ETA 00:05[K[download]  62.3% of 46.79MiB at  4.61MiB/s ETA 00:03[K[download]  62.3% of 46.79MiB at  1.71MiB/s ETA 00:10[K[download]  62.4% of 46.79MiB at  1.83MiB/s ETA 00:09[K[download]  62.5% of 46.79MiB at  2.73MiB/s ETA 00:06[K[download]  62.8% of 46.79MiB at  3.69MiB/s ETA 00:04[K[download]  63.3% of 46.79MiB at  5.25MiB/s ETA 00:03[K[download]  64.4% of 46.79MiB at  7.89MiB/s ETA 00:02[K[download]  66.5% of 46.79MiB at  9.96MiB/s ETA 00:01[K[download]  70.8% of 46.79MiB at 11.33MiB/s ETA 00:01[K[download]  79.4% of 46.79MiB at 10.84MiB/s ETA 00:00[K[download]  83.4% of 46.79MiB at 10.70MiB/s ETA 00:00[K[download]  83.4% of 46.79MiB at Unknown speed ETA Unknown ETA[K[download]  83.4% of 46.79MiB at  1.12MiB/s ETA 00:07[K[download]  83.4% of 46.79MiB at  1.72MiB/s ETA 00:04[K[download]  83.5% of 46.79MiB at  2.74MiB/s ETA 00:02[K[download]  83.5% of 46.79MiB at  1.88MiB/s ETA 00:04[K[download]  83.6% of 46.79MiB at  2.06MiB/s ETA 00:03[K[download]  83.7% of 46.79MiB at  2.82MiB/s ETA 00:02[K[download]  84.0% of 46.79MiB at  4.11MiB/s ETA 00:01[K[download]  84.5% of 46.79MiB at  6.32MiB/s ETA 00:01[K[download]  85.6% of 46.79MiB at  8.96MiB/s ETA 00:00[K[download]  87.7% of 46.79MiB at  9.23MiB/s ETA 00:00[K[download]  92.0% of 46.79MiB at 10.06MiB/s ETA 00:00[K[download] 100.0% of 46.79MiB at  9.95MiB/s ETA 00:00[K[download] 100% of 46.79MiB in 00:04
[download] Destination: /data/data/com.termux/files/home/storage/shared/Music/Lil Wayne - Hollyweezy (Official Music Video).f251.webm
[K[download]   0.0% of 5.30MiB at 126.74KiB/s ETA 00:43[K[download]   0.1% of 5.30MiB at 233.63KiB/s ETA 00:23[K[download]   0.1% of 5.30MiB at 436.84KiB/s ETA 00:12[K[download]   0.3% of 5.30MiB at 702.73KiB/s ETA 00:07[K[download]   0.6% of 5.30MiB at  1.35MiB/s ETA 00:03[K[download]   1.2% of 5.30MiB at  2.56MiB/s ETA 00:02[K[download]   2.3% of 5.30MiB at  3.02MiB/s ETA 00:01[K[download]   4.7% of 5.30MiB at  4.21MiB/s ETA 00:01[K[download]   9.4% of 5.30MiB at  5.84MiB/s ETA 00:00[K[download]  18.8% of 5.30MiB at  8.01MiB/s ETA 00:00[K[download]  37.7% of 5.30MiB at 10.02MiB/s ETA 00:00[K[download]  75.5% of 5.30MiB at 10.73MiB/s ETA 00:00[K[download] 100.0% of 5.30MiB at 11.21MiB/s ETA 00:00[K[download] 100% of 5.30MiB in 00:00
[ffmpeg] Merging formats into "/data/data/com.termux/files/home/storage/shared/Music/Lil Wayne - Hollyweezy (Official Music Video).mkv"
Deleting original file /data/data/com.termux/files/home/storage/shared/Music/Lil Wayne - Hollyweezy (Official Music Video).f137.mp4 (pass -k to keep)
Deleting original file /data/data/com.termux/files/home/storage/shared/Music/Lil Wayne - Hollyweezy (Official Music Video).f251.webm (pass -k to keep)
[fromtitle] parsed artist: Lil Wayne
[fromtitle] parsed title: Hollyweezy (Official Music Video)
[ffmpeg] Adding metadata to '/data/data/com.termux/files/home/storage/shared/Music/Lil Wayne - Hollyweezy (Official Music Video).mkv'


# COMMAND THAT WORKS
# DOWNLOAD MP3 WITH PROPER METADATA
Now that we have a functional command it'll be trivial to remove 
"-x --audio-format mp3" so we download a video [test if we need to pass -k or
not] and then we can get a playlist version and we're gucci!

u0_a144@localhost:~/projects/dotfiles/unix/bin (termux *)$ youtube-dl --no-mtime -o "/data/data/com.termux/files/home/storage/shared/Music/%(title)s.%(ext)s" --metadata-from-title "%(artist)s - %(title)s" --add-metadata -x --audio-format mp3 --prefer-ffmpeg https://youtu.be/Y4QVpt0Ikdg  >> yt-results.md


[youtube] Y4QVpt0Ikdg: Downloading webpage
[youtube] Y4QVpt0Ikdg: Downloading video info webpage
[youtube] Y4QVpt0Ikdg: Extracting video information
[download] Destination: /data/data/com.termux/files/home/storage/shared/Music/kendrick lamar & J. cole - Black Friday (lyrics).webm
[K[download]   0.0% of 6.83MiB at 96.35KiB/s ETA 01:14[K[download]   0.0% of 6.83MiB at 240.87KiB/s ETA 00:29[K[download]   0.1% of 6.83MiB at 482.34KiB/s ETA 00:14[K[download]   0.2% of 6.83MiB at 912.51KiB/s ETA 00:07[K[download]   0.4% of 6.83MiB at 932.19KiB/s ETA 00:07[K[download]   0.9% of 6.83MiB at 949.28KiB/s ETA 00:07[K[download]   1.8% of 6.83MiB at  1.06MiB/s ETA 00:06[K[download]   3.6% of 6.83MiB at 467.70KiB/s ETA 00:14[K[download]   7.3% of 6.83MiB at 258.01KiB/s ETA 00:25[K[download]   9.9% of 6.83MiB at 223.52KiB/s ETA 00:28[K[download]  12.2% of 6.83MiB at 211.07KiB/s ETA 00:29[K[download]  14.6% of 6.83MiB at 207.57KiB/s ETA 00:28[K[download]  17.3% of 6.83MiB at 201.36KiB/s ETA 00:28[K[download]  19.8% of 6.83MiB at 196.97KiB/s ETA 00:28[K[download]  22.3% of 6.83MiB at 193.15KiB/s ETA 00:28[K[download]  24.6% of 6.83MiB at 191.59KiB/s ETA 00:27[K[download]  27.2% of 6.83MiB at 189.16KiB/s ETA 00:26[K[download]  29.6% of 6.83MiB at 188.05KiB/s ETA 00:26[K[download]  32.1% of 6.83MiB at 187.25KiB/s ETA 00:25[K[download]  34.7% of 6.83MiB at 186.07KiB/s ETA 00:24[K[download]  37.1% of 6.83MiB at 184.80KiB/s ETA 00:23[K[download]  39.5% of 6.83MiB at 184.52KiB/s ETA 00:22[K[download]  42.1% of 6.83MiB at 182.87KiB/s ETA 00:22[K[download]  44.4% of 6.83MiB at 183.03KiB/s ETA 00:21[K[download]  47.1% of 6.83MiB at 182.90KiB/s ETA 00:20[K[download]  49.7% of 6.83MiB at 181.40KiB/s ETA 00:19[K[download]  51.9% of 6.83MiB at 180.98KiB/s ETA 00:18[K[download]  54.4% of 6.83MiB at 180.48KiB/s ETA 00:17[K[download]  56.8% of 6.83MiB at 180.48KiB/s ETA 00:16[K[download]  59.4% of 6.83MiB at 180.22KiB/s ETA 00:15[K[download]  61.9% of 6.83MiB at 179.72KiB/s ETA 00:14[K[download]  64.3% of 6.83MiB at 179.03KiB/s ETA 00:13[K[download]  66.6% of 6.83MiB at 179.70KiB/s ETA 00:12[K[download]  69.5% of 6.83MiB at 179.79KiB/s ETA 00:11[K[download]  72.1% of 6.83MiB at 179.17KiB/s ETA 00:10[K[download]  74.4% of 6.83MiB at 179.21KiB/s ETA 00:09[K[download]  77.0% of 6.83MiB at 179.20KiB/s ETA 00:08[K[download]  79.6% of 6.83MiB at 179.01KiB/s ETA 00:07[K[download]  82.1% of 6.83MiB at 178.68KiB/s ETA 00:07[K[download]  84.5% of 6.83MiB at 178.50KiB/s ETA 00:06[K[download]  86.9% of 6.83MiB at 178.15KiB/s ETA 00:05[K[download]  89.3% of 6.83MiB at 178.35KiB/s ETA 00:04[K[download]  92.0% of 6.83MiB at 177.75KiB/s ETA 00:03[K[download]  94.3% of 6.83MiB at 177.83KiB/s ETA 00:02[K[download]  96.8% of 6.83MiB at 177.81KiB/s ETA 00:01[K[download]  99.4% of 6.83MiB at 177.37KiB/s ETA 00:00[K[download] 100.0% of 6.83MiB at 177.94KiB/s ETA 00:00[K[download] 100% of 6.83MiB in 00:39
[fromtitle] parsed artist: kendrick lamar & J. cole
[fromtitle] parsed title: Black Friday (lyrics)
[ffmpeg] Destination: /data/data/com.termux/files/home/storage/shared/Music/kendrick lamar & J. cole - Black Friday (lyrics).mp3
Deleting original file /data/data/com.termux/files/home/storage/shared/Music/kendrick lamar & J. cole - Black Friday (lyrics).webm (pass -k to keep)
[ffmpeg] Adding metadata to '/data/data/com.termux/files/home/storage/shared/Music/kendrick lamar & J. cole - Black Friday (lyrics).mp3'




## Videos no playlist

[youtube] abrcJ9MpF60: Downloading webpage
[youtube] abrcJ9MpF60: Downloading video info webpage
[youtube] abrcJ9MpF60: Extracting video information
[download] Destination: /data/data/com.termux/files/home/storage/shared/Videos/Al Sweigart   Yes, It's Time to Learn Regular Expressions   PyCon 2017.mp4
[K[download]   0.0% of 74.79MiB at 191.51KiB/s ETA 06:49[K[download]   0.0% of 74.79MiB at 466.53KiB/s ETA 02:46[K[download]   0.0% of 74.79MiB at 929.91KiB/s ETA 01:23[K[download]   0.0% of 74.79MiB at  1.59MiB/s ETA 00:48[K[download]   0.0% of 74.79MiB at  1.68MiB/s ETA 00:44[K[download]   0.1% of 74.79MiB at  1.73MiB/s ETA 00:43[K[download]   0.2% of 74.79MiB at  2.34MiB/s ETA 00:31[K[download]   0.3% of 74.79MiB at  3.51MiB/s ETA 00:21[K[download]   0.7% of 74.79MiB at  5.35MiB/s ETA 00:13[K[download]   1.3% of 74.79MiB at  7.91MiB/s ETA 00:09[K[download]   2.7% of 74.79MiB at 10.15MiB/s ETA 00:07[K[download]   5.3% of 74.79MiB at 10.72MiB/s ETA 00:06[K[download]  10.7% of 74.79MiB at  9.92MiB/s ETA 00:06[K[download]  16.0% of 74.79MiB at  9.91MiB/s ETA 00:06[K[download]  21.4% of 74.79MiB at  9.85MiB/s ETA 00:05[K[download]  26.7% of 74.79MiB at  9.87MiB/s ETA 00:05[K[download]  32.1% of 74.79MiB at 10.13MiB/s ETA 00:05[K[download]  37.4% of 74.79MiB at 10.51MiB/s ETA 00:04[K[download]  42.8% of 74.79MiB at 10.90MiB/s ETA 00:03[K[download]  48.1% of 74.79MiB at 10.84MiB/s ETA 00:03[K[download]  53.5% of 74.79MiB at 10.80MiB/s ETA 00:03[K[download]  58.8% of 74.79MiB at 10.87MiB/s ETA 00:02[K[download]  64.2% of 74.79MiB at 10.36MiB/s ETA 00:02[K[download]  69.5% of 74.79MiB at  9.94MiB/s ETA 00:02[K[download]  74.9% of 74.79MiB at  9.82MiB/s ETA 00:01[K[download]  80.2% of 74.79MiB at  9.87MiB/s ETA 00:01[K[download]  85.6% of 74.79MiB at  9.74MiB/s ETA 00:01[K[download]  90.9% of 74.79MiB at  9.55MiB/s ETA 00:00[K[download]  96.3% of 74.79MiB at  9.33MiB/s ETA 00:00[K[download] 100.0% of 74.79MiB at  9.21MiB/s ETA 00:00[K[download] 100% of 74.79MiB in 00:08
[fromtitle] Could not interpret title of video as "%(artist)s - %(title)s"
[ffmpeg] Adding metadata to '/data/data/com.termux/files/home/storage/shared/Videos/Al Sweigart   Yes, It's Time to Learn Regular Expressions   PyCon 2017.mp4'
