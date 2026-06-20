# 親要素に対してabsolute


https://stackoverflow.com/questions/10487292/position-absolute-but-relative-to-parent

親要素に`position: relative;`を指定する

```css
<div id="father">
   <div id="son1"></div>
   <div id="son2"></div>
</div>

#father {
   position: relative;
}

#son1 {
   position: absolute;
   top: 0;
}

#son2 {
   position: absolute;
   bottom: 0;
}

```