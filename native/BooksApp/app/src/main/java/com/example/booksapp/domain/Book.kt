package com.example.booksapp.domain

data class Book (
    val id: Int,
    val title: String,
    val author: String,
    val year: Int,
    val lent: Boolean,
)