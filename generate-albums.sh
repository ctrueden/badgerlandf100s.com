#!/bin/sh

#
# generate-albums.sh
#

# This script generates the albums for the site.
#
# 1. Upload album to Google Photos.
#
# 2. Obtain HTML block for the album using this site:
#    https://www.publicalbum.org/blog/embedding-google-photos-albums
#
# 3. Paste HTML block into publicalbums/myalbum.html file,
#    where 'myalbum' is the desired ID of the album.
#
# 4. Convert HTML blocks to format compatible with this web site:
#    sh generate-albums.sh
#
# 5. Commit new and changed to git, then push to GitHub.

tag_value () {
  echo $(grep "$1" "$2" | head -n1 | sed 's/[^"]*"\([^"]*\)".*/\1/')
}

# -- Generate albums overview page --
overview_page=_data/galleries/overview.yml
echo "Generating $overview_page..."
echo "image_width: 300px" >  "$overview_page"
echo "albums:" >> "$overview_page"
for infile in publicalbums/*.html
do
  f=$(basename "$infile")
  id=${f%.*}
  link=$(tag_value data-link "$infile")
  title=$(tag_value data-title "$infile")
  description=$(tag_value data-description "$infile")
  image=$(tag_value data-src "$infile")
  echo "-" >> "$overview_page"
  echo " id: $id" >> "$overview_page"
  echo " link: \"$link\"" >> "$overview_page"
  echo " title: \"$title\"" >> "$overview_page"
  echo " description: \"$description\"" >> "$overview_page"
  echo " image: \"$image\"" >> "$overview_page"
done

# -- Generate YML metadata for each album --
for infile in publicalbums/*.html
do
  f=$(basename "$infile")
  id=${f%.*}
  outfile="_data/galleries/$id.yml"
  echo "$infile -> $outfile"
  echo 'pictures:' > "$outfile" &&
  grep img "$infile" | sed 's/[^"]*"\([^"]*\)".*/- \1/g' >> "$outfile"
done
