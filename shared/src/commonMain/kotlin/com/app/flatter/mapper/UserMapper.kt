package com.app.flatter.mapper

import com.app.flatter.businessModels.UserModel
import models.GetUserInfoResponse

class UserMapper : BaseMapper<GetUserInfoResponse, UserModel> {
    override fun invoke(state: GetUserInfoResponse) = with(state) {
        UserModel(
            name = name,
            email = email,
            phoneNumber = phone
        )
    }
}