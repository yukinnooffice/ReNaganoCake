$(function(){
    $('#product_image').on('change', function (e) {
    var reader = new FileReader();
    reader.onload = function (e) {
        $(".image").attr('src', e.target.result);
    }
    reader.readAsDataURL(e.target.files[0]); //取得したurlにアップロード画像のurlを挿入
  });
});