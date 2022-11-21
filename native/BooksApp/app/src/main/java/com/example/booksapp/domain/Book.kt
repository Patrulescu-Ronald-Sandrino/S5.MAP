package com.example.booksapp.domain

import androidx.room.ColumnInfo
import androidx.room.Entity
import androidx.room.PrimaryKey
import com.example.booksapp.core.Constraints

@Entity(tableName = Constraints.BOOK_TABLE)
data class Book (
    @PrimaryKey(autoGenerate = true) @ColumnInfo(name = "id") val id: Int,
    @ColumnInfo(name = "title") val title: String,
    @ColumnInfo(name = "author") val author: String,
    @ColumnInfo(name = "year") val year: Int,
    @ColumnInfo(name = "lent") val lent: Boolean,
)