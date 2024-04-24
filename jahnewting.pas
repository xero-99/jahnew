program SalesApp;

const
  PRODUCT_D_COST = 200;
  PRODUCT_F_COST = 800;
  PRODUCT_FD_COST = 960;
  PRODUCT_P_COST = 150;
  PRODUCT_PD_COST = 340;
  PRODUCT_PF_COST = 920;
  
  DISCOUNT_THRESHOLD = 1000;
  DISCOUNT_RATE = 0.1;
  GCT_RATE = 0.15;

type
  ProductType = (Pastry, Food, Drinks, PastryDrinks, PastryFood, FoodDrinks);

var
  total_cash, total_card, total_sales: real;
  product_counts: array[ProductType] of integer;
  customer_id, last_name, contact_number: string;
  product_type: ProductType;
  payment_method, continue_or_exit: string;
  quantity, subtotal, total: real;
  p: ProductType; // Loop variable declaration

procedure CalculateSale;
var
  product_code: char;
begin
  writeln('Enter customer ID: ');
  readln(customer_id);
  writeln('Enter last name: ');
  readln(last_name);
  writeln('Enter contact number: ');
  readln(contact_number);
  writeln('Enter product code (A-F): '); // Corrected prompt to use product code
  readln(product_code);
  product_type := ProductType(Ord(product_code) - Ord('A')); // Convert char to ProductType
  writeln('Enter quantity: ');
  readln(quantity);

  case product_code of
    'A': subtotal := quantity * PRODUCT_A_COST;
    'B': subtotal := quantity * PRODUCT_B_COST;
    'C': subtotal := quantity * PRODUCT_C_COST;
    'D': subtotal := quantity * PRODUCT_D_COST;
    'E': subtotal := quantity * PRODUCT_E_COST;
    'F': subtotal := quantity * PRODUCT_F_COST;
  end;

  if subtotal > DISCOUNT_THRESHOLD then
    subtotal := subtotal * (1 - DISCOUNT_RATE);
  total := subtotal + subtotal * GCT_RATE;

  repeat
    writeln('Enter payment method (cash or card): ');
    readln(payment_method);
  until (payment_method = 'cash') or (payment_method = 'card'); // Corrected condition

  if payment_method = 'cash' then
    total_cash := total_cash + total
  else
    total_card := total_card + total;
  total_sales := total_sales + total;
  product_counts[product_type] := product_counts[product_type] + round(quantity);
end;

begin
  total_cash := 0;
  total_card := 0;
  total_sales := 0;

  for p := Low(ProductType) to High(ProductType) do
    product_counts[p] := 0;

  repeat
    CalculateSale;
    writeln('Enter "exit" to end or any other key to continue: ');
    readln(continue_or_exit);
  until continue_or_exit = 'exit';

  writeln('Total cash collected: ', total_cash:0:2);
  writeln('Total card collected: ', total_card:0:2);
  writeln('Total sales: ', total_sales:0:2);
  writeln('Product counts:');
  for p := Low(ProductType) to High(ProductType) do
    writeln(p, ': ', product_counts[p]);
end.

