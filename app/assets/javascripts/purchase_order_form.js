

$(document).ready(function () {
  $(document).on(
    "change",
    'select[name^="purchase_order[purchase_order_line_items_attributes]"]',
    function () {
      var productId = $(this).val();
      var measuredInInput = $(this)
        .closest("div")
        .find('input[name$="[measured_in]"]');
      measuredInInput.val(productId);

      $.ajax({
        url: "/admin/purchase_orders/measured_in",
        method: "GET",
        data: { product_id: productId },
        traditional: true,
        success: function (response) {
          measuredInInput.val(response.measured_in);
        },
        error: function (xhr, status, error) {
          console.error(error);
        },
      });
    }
  );
});
