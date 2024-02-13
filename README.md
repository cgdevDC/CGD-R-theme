# CGD-R-theme
A ggplot2 theme for CGD graphs

---

## Guide: [CGD Sharepoint](https://centerforglobaldevelop.sharepoint.com/sites/fileshare/Shared%20Documents/Forms/AllItems.aspx?ga=1&id=%2Fsites%2Ffileshare%2FShared%20Documents%2FNDrive%2FCommunications%2FCGD%20Branding%20Materials%2FCGD%2DData%2DViz%2DStyle%2DGuide%2Epdf&viewid=23e5bfee%2D12a8%2D4a15%2Dac13%2Dfba17c53a2db&parent=%2Fsites%2Ffileshare%2FShared%20Documents%2FNDrive%2FCommunications%2FCGD%20Branding%20Materials)


## This script:

1) Provides the colors and color order to use CGD colors for graphs. 

2) Provides a theme_cgd object that can be added to ggplots to automate non-data aspects of plots.


## Colors 

It's not really possible to automate how color is used, as it depends so
much on the data. Below are some general instructions on how the guide
recommends they be used (but feel free to experiment yourself).

There are three types of color order: categorical is for non-ordered, categorical
variables; sequential is for neutral or all-positive scales/gradations,
like 10%>20%>30% or good>better>best; polar is for when there is a negative
component, like -10%>0>10% or bad>neutral>good.

For each of sequential and polar, there are several options depending on how
much of a range of color the user wants the scale to cover. Will generally
want to use sequential2 or sequential3 (looks cleaner), but if they want to
tease out differences in middle parts of the scale they can use higher.

When using `scale_fill_discrete()` or `scale_color_discrete()` with polar or sequential,
you can use `type = sequential` or `type = polar` and ggplot will automatically
use the version with the same number of colors as levels of the factor it is graphing.

For sequential, an alternative is using alpha: set alpha = continuous_variable within aes,
and use fill = light_teal (or another CGD color) outside of it

Note that guide also recommends light gray to denote 'none/neutral' for categorical
or sequential graphs. If you use all light gray for category or part of sequence,
and also have none/neutral elements, then need to use a different color to denote 'none/neutral'



## CGD theme

You can just save theme_cgd as an object and then add it to a graph like this:

```
ggplot(data) +
  geom_point(aes(x, y)) +
  theme_cgd
```

Note, no brackets after.

Ideally, this would be a one-size-fits-all add-on, but in practice users
will still need to make modifications. You can modify the specs here by adding 
on your own `theme()` after `theme_cgd` - note it must be after, otherwise `theme_cgd`
will just overwrite it.

Note that placing y-axis title above axis (on top left) is only possible by
setting the plot subtitle as the desired y-axis title. Set subtitle with
`labs(subtitle = "This is a subtitle")`.

CGD graphs should use the "Sofia Pro" font, available [here](https://centerforglobaldevelop.sharepoint.com/sites/fileshare/Shared%20Documents/Forms/AllItems.aspx?ga=1&id=%2Fsites%2Ffileshare%2FShared%20Documents%2FNDrive%2FCommunications%2FCGD%20Branding%20Materials%2FCGD%20Fonts&viewid=23e5bfee%2D12a8%2D4a15%2Dac13%2Dfba17c53a2db).

First download them, then open each one and press install; this should automatically
install them to your system fonts (`"C:\Windows\Fonts"` or similar) and make
them available to R. You will need to close R down and reopen it (not just restart the session to make this work).

Other plot features (projections, trend lines, separators) are data features
and therefore need to be added and styled manually.


