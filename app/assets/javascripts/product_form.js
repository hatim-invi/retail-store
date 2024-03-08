$(document).ready(function () {
  $("#product_category_id").on("change", function () {
    var categoryValue = $("#product_category_id").val();

    $.ajax({
      url: "/admin/sub_categories/get_categories",
      data: {
        id: categoryValue,
      },
      type: "GET",
      traditional: true,
      success: function (response) {
        $("#product_sub_category_id").prop("disabled", false);
        $("#product_sub_category_id").empty(); // Clear existing options
        $.each(response, function (index, subCategory) {
          $("#product_sub_category_id").append(
            $("<option>", {
              value: subCategory.id,
              text: subCategory.name,
            })
          );
        });
      },
      error: function (xhr) {
        console.log(xhr);
      },
    });
  });
});
