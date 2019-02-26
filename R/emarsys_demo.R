source("global.R")

## ---- Motivating example
# Random picture --> works almost perfectly
motivating_example_cat <- image_read("data/Screen Shot 2018-08-29 at 09.58.16.png")
ocr(motivating_example_cat) %>% cat()

# Something from an email campaign
motivating_example_from_email <- image_read("data/md_178674.jpg")
ocr(motivating_example_from_email) %>% cat()


## ---- Harder example
motivating_example_incentive <- image_read("data/180112_Additional_20_Off_Clearance_FINAL_07.jpg")
ocr(motivating_example_incentive) %>% cat()


## ---- Playing around with Magick

# Binarisation
stylish_guy_with_discount_jacket <- image_read("data/STYLISH25.jpg")
ocr(stylish_guy_with_discount_jacket) %>% cat()
stylish_guy_with_discount_jacket %>% 
	image_convert(colorspace = "gray") %>% 
	ocr() %>% 
	cat()

# Border removal
bulk_powder_guy <- image_read("data/md_344892.jpg")
bulk_powder_guy %>% ocr() %>% cat()
bulk_powder_guy %>% 
	image_trim(fuzz = 98) %>% 
	ocr() %>% 
	cat()

# example of applied transformations not helping
gunmoney <- image_read("data/md_1521023.jpg")
ocr(gunmoney) %>% cat()
gunmoney %>% 
	image_convert(colorspace = "gray") %>% 
	image_trim(fuzz = 35) %>% 
	ocr() %>% 
	cat()

# bit of fun
foot <- image_read("data/md_178674.jpg")
image_charcoal(foot)
image_edge(foot)

# Noise removal
image_noise(foot)
image_noise(foot) %>% image_reducenoise(1)

# Rotation / deskewing
skewed <- image_read("data/skewed.png")
ocr(skewed) %>% cat()

## ---- Tesseract config & other thoughts
tesseract_params(filter = 'tessedit_char')
#see: https://cran.r-project.org/web/packages/tesseract/vignettes/intro.html

# Chr list example
receipt <- image_read("https://jeroen.github.io/images/receipt.png")
ocr(receipt) %>% cat()

engine_only_numbers <- tesseract(options = list(tessedit_char_whitelist = ".0123456789"))
ocr(receipt, engine = engine_only_numbers) %>% cat()

# Dictionaries & word lists
bigram_freqs <- fread(
	"data/hun.training_text.bigram_freqs.txt",  
	col.names = c("bigram", "frequency_score"),
	sep       = " ",
	quote     = ""
)

head(bigram_freqs[order(-frequency_score)], 10)

# Page segmentation method !!!
tesseract_params("tessedit_pageseg_mode")[["desc"]]

kitchenaid_two_parts <- image_read("data/180923_ElectricsEvent_FINAL_06.png")
ocr(kitchenaid_two_parts) %>% cat()
kitchenaid_two_parts %>%
	ocr(engine = tesseract('eng', options = list(tessedit_pageseg_mode = 2))) %>%
	cat()

bulk_powder_somuchtext <- image_read("data/md_11194.jpg")
ocr(bulk_powder_somuchtext) %>% cat()
bulk_powder_somuchtext %>%
	ocr(engine = tesseract('eng', options = list(tessedit_pageseg_mode = 2))) %>%
	cat()


## ----
meszarsteak <- image_read("data/meszarSteakMenu.png")
meszarsteak %>% 
    ocr(engine = tesseract('eng', options = list(tessedit_pageseg_mode = 2))) %>% 
    cat()
