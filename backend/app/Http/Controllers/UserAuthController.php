<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;

class UserAuthController extends Controller
{
  public function register(Request $request){
    try {
      $registerUserData = $request->validate([
        'name'=>'required|string',
        'email'=>'required|string|email|unique:users',
        'password'=>'required'
    ]);
    $user = User::create([
        'name' => $registerUserData['name'],
        'email' => $registerUserData['email'],
        'password' => $registerUserData['password'],
    ]);
    return response()->json([
        'message' => 'suksess ',
    ]);
    } catch (\Throwable $th) {
      return response()->json([
        'message' => "error"
      ]);
    }
  }

  public function login(Request $request){
    $loginUserData = $request->validate([
        'email'=>'required|string|email',
        'password'=>'required'
    ]);
    $user = User::where('email',$loginUserData['email'])->first();
    if(!$user || !Hash::check($loginUserData['password'],$user->password)){
        return response()->json([
            'message' => 'Email atau password salah'
        ],401);
    }
    $token = $user->createToken($user->name.'-AuthToken')->plainTextToken;
    return response()->json([
      'status' => 'success',
      'data' => [
          'access_token' => $token,
          'name' => $user->name,
      ],
      'message' => 'Login successful'
    ], 200);
  
  }

    public function logout(){
      auth()->user()->tokens()->delete();

      return response()->json([
        "message"=>"logged out"
      ]);
    }


    public function index(){
      $users = User::all();

      return response()->json([
          "users" => $users
      ], 200);
    }
}
