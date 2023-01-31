package com.example.booksapp.data.network;

import androidx.room.Database;
import androidx.room.RoomDatabase;

import com.example.booksapp.domain.Book;

@Database(entities = [Book::class], version = 1, exportSchema = true)
abstract class BookDatabase : RoomDatabase() {
    abstract fun bookDAO(): BookDAO
}