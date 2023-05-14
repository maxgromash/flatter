package com.app.flatter.mapper

import com.app.flatter.businessModels.UserModel
import models.GetUserInfoResponse

class UserMapper: BaseMapper<GetUserInfoResponse, UserModel> {
    override fun invoke(state: GetUserInfoResponse): UserModel {
        return UserModel(
            name = state.name,
            email = state.email,
            phoneNumber = state.phone
        )
    }
}