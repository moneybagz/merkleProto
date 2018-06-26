//
//  AuthService.swift
//  merkleProto
//
//  Created by Clyfford Millet on 6/11/18.
//  Copyright © 2018 Clyff Millet. All rights reserved.
//

import Foundation
import Firebase

class AuthService {
    static let instance = AuthService()
    
    func registerUser(withEmail email: String, andPassword password: String, userCreationComplete: @escaping (_ status:Bool, _ error: Error?) -> ()) {
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            guard let user = user else {
                userCreationComplete(false, error)
                return
            }
            
            let userData = ["provider": user.user.providerID, "email": user.user.email]
            DataService.instance.createDBUser(uid: user.user.uid, userData: userData)
            userCreationComplete(true, nil)
        }
    }
    
    func loginUser(withEmail email: String, andPassword password: String, loginComplete: @escaping (_ status: Bool, _ error: Error?) ->()) {
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error != nil {
                loginComplete(false, error)
                return
            }
            loginComplete(true, nil)
        }
    }
    
//    func fireErrorHandle(error: NSError) {
//        if let errorCode = AuthErrorCode(rawValue: error.code) {
//        switch errorCode {
//            case .invalidCustomToken:
//                print(" a validation error with the custom token")
//            case .customTokenMismatch:
//                print(" the service account and the API key belong to different projects")
//            case .invalidCredential:
//                print(" the IDP token or requestUri is invalid")
//            case .userDisabled:
//                print(" the user's account is disabled on the server")
//            case .operationNotAllowed:
//                print(" the administrator disabled sign in with the specified identity provider")
//            case .emailAlreadyInUse:
//                print(" the email used to attempt a sign up is already in use.")
//            case .invalidEmail:
//                print(" the email is invalid")
//            case .wrongPassword:
//                print(" the user attempted sign in with a wrong password")
//            case .tooManyRequests:
//                print(" that too many requests were made to a server method")
//            case .userNotFound:
//                print(" the user account was not found")
//            case .accountExistsWithDifferentCredential:
//                print(" account linking is required")
//            case .requiresRecentLogin:
//                print(" the user has attemped to change email or password more than 5 minutes after signing in")
//            case .providerAlreadyLinked:
//                print(" an attempt to link a provider to which the account is already linked")
//            case .noSuchProvider:
//                print(" an attempt to unlink a provider that is not linked")
//            case .invalidUserToken:
//                print(" user's saved auth credential is invalid, the user needs to sign in again")
//            case .networkError:
//                print(" a network error occurred ")
//            case .userTokenExpired:
//                print(" the saved token has expired, for example, the user may have changed account password on another device. The user needs to sign in again on the device that made this request")
//            case .invalidAPIKey:
//                print(" an invalid API key was supplied in the request")
//            case .userMismatch:
//                print(" that an attempt was made to reauthenticate with a user which is not the current user")
//            case .credentialAlreadyInUse:
//                print(" an attempt to link with a credential that has already been linked with a different Firebase account")
//            case .weakPassword:
//                print(" an attempt to set a password that is considered too weak")
//            case .appNotAuthorized:
//                print(" the App is not authorized to use Firebase Authentication with the provided API Key")
//            case .keychainError:
//                print(" an error occurred while attempting to access the keychain")
//            default:
//                print(" an internal error occurred")
//            }
//        }
//    }
}

//extension AuthErrorCode {
//    var errorMessage: String {
//        switch self {
//        case .emailAlreadyInUse:
//            return "The email is already in use with another account"
//        case .userNotFound:
//            return "Account not found for the specified user. Please check and try again"
//        case .userDisabled:
//            return "Your account has been disabled. Please contact support."
//        case .invalidEmail, .invalidSender, .invalidRecipientEmail:
//            return "Please enter a valid email"
//        case .networkError:
//            return "Network error. Please try again."
//        case .weakPassword:
//            return "Your password is too weak. The password must be 6 characters long or more."
//        case .wrongPassword:
//            return "Your password is incorrect. Please try again or use 'Forgot password' to reset your password"
//        default:
//            return "Unknown error occurred"
//        }
//    }
//}
