import 'dart:convert';
import 'package:dbkliknew/utils/StorageUtils.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static String? _baseUrl;

  static Future<void> setBaseUrl(String baseUrl) async {
    // Perform any asynchronous operations if needed
    await Future.delayed(const Duration(seconds: 1));

    _baseUrl = baseUrl;
  }

  Future<String?> login(String email, String password) async {
    if (_baseUrl == null) {
      print(
          'Error: Base URL is not set. Call setBaseUrl before making requests.');
      return null;
    }

    try {
      final Uri loginUri = Uri.parse('$_baseUrl/api/login');
      final Map<String, dynamic> requestBody = {
        'email': email,
        'pass': password,
      };

      final response = await http.post(
        loginUri,
        body: requestBody,
      );

      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);

        if (responseData.isNotEmpty &&
            responseData[0] is Map<String, dynamic>) {
          final String token = responseData[0]['token'];
          return token;
        } else {
          print('Unexpected response format: $responseData');
          return null;
        }
      } else {
        print('Login failed with status code: ${response.statusCode}');
        return null;
      }
    } catch (error) {
      print('Error during login: $error');
      return null;
    }
  }

  // Function to perform the registration API call
  Future<String?> registerUser(
      String name, String email, String phone, String password) async {
    if (_baseUrl == null) {
      print(
          'Error: Base URL is not set. Call setBaseUrl before making requests.');
      return null;
    }

    try {
      final Uri registerUri = Uri.parse('$_baseUrl/api/register');
      final Map<String, dynamic> requestBody = {
        'name': name,
        'email': email,
        'phone': phone,
        'password': password,
      };

      final response = await http.post(
        registerUri,
        body: requestBody,
      );

      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);

        if (responseData.isNotEmpty &&
            responseData[0] is Map<String, dynamic>) {
          final String token = responseData[0]['token'];
          return token;
        } else {
          print('Unexpected response format: $responseData');
          return null;
        }
      } else {
        print('Registration failed with status code: ${response.statusCode}');
        return null;
      }
    } catch (error) {
      print('Error during registration: $error');
      return null;
    }
  }

  Future<dynamic> getAllBrand() async {
    if (_baseUrl == null) {
      print(
          'Error: Base URL is not set. Call setBaseUrl before making requests.');
      return null;
    }

    try {
      final Uri apiUrl = Uri.parse('$_baseUrl/api/brands');
      final response = await http.get(apiUrl);

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        print('Request failed with status code: ${response.statusCode}');
        return null;
      }
    } catch (error) {
      print('Error during API request: $error');
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> fetchFlashSaleData() async {
    if (_baseUrl == null) {
      print(
          'Error: Base URL is not set. Call setBaseUrl before making requests.');
      return [];
    }

    try {
      final Uri apiUrl = Uri.parse('$_baseUrl/api/flash');
      final response = await http.get(apiUrl);

      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);
        return List<Map<String, dynamic>>.from(responseData);
      } else {
        print('Request failed with status code: ${response.statusCode}');
        return [];
      }
    } catch (error) {
      print('Error during API request: $error');
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> fetchProductsForBrand(int brandId) async {
    final response =
        await http.get(Uri.parse('$_baseUrl/api/products/brand/$brandId'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return List<Map<String, dynamic>>.from(data);
    } else {
      throw Exception('Failed to load products');
    }
  }

  Future<int> getUserId() async {
    try {
      final String? token = await StorageUtils.getTokenFromStorage();

      if (token == null) {
        // Handle the case where the token is not available
        throw Exception('Token not found');
      }

      final Uri apiUrl = Uri.parse('$_baseUrl/api/getuserdata');
      final response = await http.get(
        apiUrl,
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        // Parse the response and extract the user ID
        final Map<String, dynamic> responseData = json.decode(response.body);
        final int userId = responseData['user_id'] ?? 0;

        return userId;
      } else {
        print('Request failed with status code: ${response.statusCode}');
        throw Exception('Failed to fetch user ID');
      }
    } catch (error) {
      print('Error during fetching user ID: $error');
      throw Exception('Failed to fetch user ID');
    }
  }

  Future<void> addToWishlist(int userId, int productId) async {
    if (_baseUrl == null) {
      print(
          'Error: Base URL is not set. Call setBaseUrl before making requests.');
      return;
    }

    try {
      final Uri addToWishlistUri = Uri.parse('$_baseUrl/api/wishlist/add');
      final Map<String, dynamic> requestBody = {
        "user_id": userId,
        "product_id": productId,
      };

      final response = await http.post(
        addToWishlistUri,
        body: jsonEncode(requestBody), // Use jsonEncode to convert map to JSON
        headers: {"Content-Type": "application/json"}, // Set the content type
      );

      if (response.statusCode == 200) {
        print('Added to wishlist: User ID $userId, Product ID $productId');
      } else {
        print(
            'Adding to wishlist failed with status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error during adding to wishlist: $error');
    }
  }

  Future<void> deleteWishlistItem(int userId, int productId) async {
    try {
      final Uri deleteWishlistItemUri = Uri.parse('$_baseUrl/api/wishlist/del');
      final Map<String, dynamic> requestBody = {
        "user_id": userId.toString(), // Convert to string
        "product_id": productId.toString(), // Convert to string
      };

      final response = await http.post(
        deleteWishlistItemUri,
        body: requestBody,
      );

      if (response.statusCode == 200) {
        print('Deleted from wishlist: User ID $userId, Product ID $productId');
      } else {
        print(
            'Deleting from wishlist failed with status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error during deleting from wishlist: $error');
    }
  }

  Future<void> addToCart(int userId, int productId, int wishlistId,
      double price, String variation) async {
    try {
      final Uri addToCartUri = Uri.parse('$_baseUrl/api/cart/add');
      final Map<String, dynamic> requestBody = {
        "user_id": userId,
        "product_id": productId,
        "Wid": wishlistId,
        "price": price,
        "variation": variation,
      };

      final response = await http.post(
        addToCartUri,
        body: jsonEncode(requestBody),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        print('Added to cart: User ID $userId, Product ID $productId');
      } else {
        print('Adding to cart failed with status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error during adding to cart: $error');
    }
  }

  Future<List<Map<String, dynamic>>> searchProducts(String query) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/api/products/search/$query'),
      );

      if (response.statusCode == 200) {
        // Berhasil mendapatkan data dari API
        // Mengembalikan data dalam bentuk List<Map<String, dynamic>>
        return List<Map<String, dynamic>>.from(json.decode(response.body));
      } else {
        // Gagal mendapatkan data dari API
        print(
            'Failed to fetch search result. Status code: ${response.statusCode}');
        // Mengembalikan list kosong jika gagal
        return [];
      }
    } catch (error) {
      print('Error during search: $error');
      // Mengembalikan list kosong jika terjadi kesalahan
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> getCartData(int userId) async {
    try {
      final Uri getCartUri = Uri.parse('$_baseUrl/api/cart/$userId');
      final response = await http.get(getCartUri);

      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);
        List<Map<String, dynamic>> cartData =
            List<Map<String, dynamic>>.from(responseData);
        return cartData;
      } else {
        print(
            'Getting cart data failed with status code: ${response.statusCode}');
        return [];
      }
    } catch (error) {
      print('Error during getting cart data: $error');
      return [];
    }
  }

  Future<bool> checkIfInWishlist(int userId, int productId) async {
    try {
      final Uri checkWishlistUri = Uri.parse('$_baseUrl/api/wishlist/check');
      final Map<String, dynamic> requestBody = {
        "user_id": userId.toString(),
        "product_id": productId.toString(),
      };

      final response = await http.post(
        checkWishlistUri,
        body: jsonEncode(requestBody),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        return responseData['is_in_wishlist'] ?? false;
      } else {
        print(
            'Checking if in wishlist failed with status code: ${response.statusCode}');
        return false;
      }
    } catch (error) {
      print('Error during checking if in wishlist: $error');
      return false;
    }
  }

  Future<List<Map<String, dynamic>>> getWishlistData(int userId) async {
    if (_baseUrl == null) {
      print(
          'Error: Base URL is not set. Call setBaseUrl before making requests.');
      return [];
    }

    try {
      final Uri apiUrl = Uri.parse('$_baseUrl/api/wishlist/$userId');
      final response = await http.get(apiUrl);

      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);
        return List<Map<String, dynamic>>.from(responseData);
      } else {
        print('Request failed with status code: ${response.statusCode}');
        return [];
      }
    } catch (error) {
      print('Error during API request: $error');
      return [];
    }
  }

  Future<dynamic> fetchBannerData() async {
    if (_baseUrl == null) {
      print(
          'Error: Base URL is not set. Call setBaseUrl before making requests.');
      return null;
    }

    try {
      final Uri apiUrl = Uri.parse('$_baseUrl/api/banner/slide');
      final response = await http.get(apiUrl);

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        print('Request failed with status code: ${response.statusCode}');
        return null;
      }
    } catch (error) {
      print('Error during API request: $error');
      return null;
    }
  }
}
